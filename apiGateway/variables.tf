variable "lambda_arn" {
  description = "Lambda ARN to invoke"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet list"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
