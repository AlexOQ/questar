module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "hw-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = true
}

module "lambda_function" {
  source = "./lamdba/"

  source_path                    = "./files/lambda_function.zip"
  function_name                  = "lambda-hw"
  vpc_subnet_ids                 = module.vpc.private_subnets
  apigatewayv2_api_execution_arn = module.api_gateway.api_execution_arn
  vpc_id                         = module.vpc.vpc_id
  source_security_group_id       = module.alb.security_group_id
}

module "api_gateway" {
  source = "./apiGateway/"

  lambda_arn     = module.lambda_function.lambda_function_arn
  public_subnets = module.vpc.private_subnets
  vpc_id         = module.vpc.vpc_id
}

module "alb" {
  source = "./alb/"

  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  lambda_target_arn = module.lambda_function.lambda_function_arn
}
