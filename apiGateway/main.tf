module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "api-gw"
  protocol_type = "HTTP"
  integrations = {
    "GET /" = {
      lambda_arn             = var.lambda_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 30000
    }
  }
  vpc_links = {
    gw-vpc = {
      name               = "gw-vpc"
      security_group_ids = [module.api_gateway_security_group.security_group_id]
      subnet_ids         = var.public_subnets
    }
  }
}

module "api_gateway_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "api-gateway-sg"
  vpc_id = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]

  egress_rules = ["all-all"]
}
