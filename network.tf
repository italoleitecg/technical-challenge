module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "challenge-vpc"
  cidr = "10.0.0.0/16"

  azs = ["us-east-1a"]
  public_subnets = ["10.0.101.0/24"]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  tags = {
    Terraform   = "true"
    Environment = "prod"
    Name        = "challenge-vpc"
  }
}