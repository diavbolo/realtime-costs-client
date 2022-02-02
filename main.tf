resource "aws_iam_role" "realtime-costs-client" {
  name = "${var.role_name}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "AWS": "${var.arn_client_role}"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}

data "aws_iam_policy_document" "ec2-readonly" {

  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }

}

resource "aws_iam_policy" "ec2-readonly" {
  name  = "${var.policy_name}"

  path   = "/"
  policy = data.aws_iam_policy_document.ec2-readonly.json
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
  role       = aws_iam_role.realtime-costs-client.name
  policy_arn = aws_iam_policy.ec2-readonly.arn
}

resource "null_resource" "update-client" {

  triggers = {
    endpoint_client = "${var.endpoint_client}",
    add = "${local.add}",
    delete = "${local.delete}",
  }

  provisioner "local-exec" {
    when    = create
    command = "curl -s -X POST -d '${self.triggers.add}' ${self.triggers.endpoint_client}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "curl -s -X POST -d '${self.triggers.delete}' ${self.triggers.endpoint_client}"
  }
}

