variable "source_path" {
  description = "Path to the source code of the Lambda function, zipped"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs to place the Lambda function in"
  type        = list(string)
}

variable "apigatewayv2_api_execution_arn" {
  description = "ARN of the API Gateway V2 API execution role"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to place the Lambda function in"
  type        = string
}

variable "source_security_group_id" {
  description = "ID of the security group to allow ingress from"
  type        = string
}
