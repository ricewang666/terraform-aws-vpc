provider "aws" {
  region = local.region
}

locals {
  region = "ap-east-1"
}


################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../../"

  name = "new-bitcharm"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a"]
  
  private_subnets       = ["10.0.21.0/24","10.0.22.0/24"]
  public_subnets        = ["10.0.101.0/24","10.0.102.0/24"]
  

  enable_ipv6 = true

  enable_nat_gateway = true
  single_nat_gateway = false
  #reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  #external_nat_ip_ids = "${aws_eip.nat.*.id}"
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    Name = "public"

  }

  private_subnet_tags = {
    Name = "private"

  }
   
  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "new-bitcharm"
  }
}
