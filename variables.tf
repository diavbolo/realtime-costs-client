variable "role_name" {
  default     = "realtime-costs-client"
}

variable "policy_name" {
  default     = "ec2-readonly"
}

variable "arn_client_role" {
  default     = "arn:aws:iam::546429776361:role/mwaa-realtime-costs-airflow-execution-role"
}

variable "endpoint_client" {
  default     = "https://api.realtime-costs.com/register"
}

variable "region" {
  default     = "eu-west-1"
}

variable "email" {
}