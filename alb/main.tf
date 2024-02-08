module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name = "alb"

  vpc_id  = var.vpc_id
  subnets = var.public_subnets



  listeners = {
    http_weighted_target = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_groups = [
          {
            target_group_key = "lambda"
          }
        ]
      }
    }

    target_groups = {
      lambda = {
        name_prefix = "l1-"
        target_type = "lambda"
        target_id   = var.lambda_target_arn
      }
    }
  }
}
