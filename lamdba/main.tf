module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  handler       = "lamdba_function.lambda_handler"
  runtime       = "python3.11"

  publish = true

  create_package         = false
  local_existing_package = var.source_path

  attach_network_policy  = true
  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = [module.lambda_security_group.security_group_id]

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway.amazonaws.com"
      source_arn = "${var.apigatewayv2_api_execution_arn}/*/*/*"
    }
  }
}

module "lambda_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "lambda-sg"
  vpc_id = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = var.source_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]
}
