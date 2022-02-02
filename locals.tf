
data "aws_caller_identity" "current" {}

locals {
  add = <<EOF
{ 
  "account_id": "${data.aws_caller_identity.current.account_id}",
  "user": "${data.aws_caller_identity.current.arn}",
  "email": "${var.email}",
  "action": "add"
}
EOF
}

locals {
  delete = <<EOF
{ 
  "account_id": "${data.aws_caller_identity.current.account_id}",
  "user": "${data.aws_caller_identity.current.arn}",
  "email": "${var.email}",
  "action": "delete"
}
EOF
}