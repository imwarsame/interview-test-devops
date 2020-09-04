#---------------------------------------------------
# STATE BACKEND
#---------------------------------------------------
terraform {
  backend "s3" {
    bucket = "example-state-bucket"
    key    = "terraform/03_infrastrcutre_test/state/terraform.tfstate"
    region = "eu-west-1"
  }
}

#---------------------------------------------------
# DATA SOURCES
#---------------------------------------------------
data "aws_ami" "selected" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
}


#---------------------------------------------------
# VPC
#---------------------------------------------------
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "${var.vpc_name}-vpc"
  cidr                 = var.cidr
  azs                  = var.azs
  public_subnets       = var.public_subnets
  enable_dns_hostnames = true
  enable_dns_support   = true
  public_subnet_tags = {
    Public = "True"
  }
  public_route_table_tags = {
    Public = "True"
  }
  tags = {
    Terraform   = "True"
    Environment = "03-infrastructure-test"
  }
}

#---------------------------------------------------
# BASTION - ASG
#---------------------------------------------------

module "bastion" {
  source                      = "terraform-aws-modules/autoscaling/aws"
  name                        = var.bastion_name
  lc_name                     = var.lc_name
  image_id                    = data.aws_ami.selected.id
  instance_type               = var.instance_type
  security_groups             = [module.bastion_ssh_sg.this_security_group_id]
  associate_public_ip_address = true
  asg_name                    = var.asg_name
  vpc_zone_identifier         = [module.vpc.public_subnets]
  health_check_type           = "EC2"
  min_size                    = 0
  max_size                    = 1
  desired_capacity            = 1
}

# ---------------------------------------------------
# BASTION - SECURITY GROUP
# ---------------------------------------------------

module "bastion_ssh_sg" {
  source              = "terraform-aws-modules/security-group/aws"
  name                = var.bastion_sg_name
  description         = "Allows ssh to the bastion from specific /32 IPs only"
  vpc_id              = data.aws_vpc.selected.id
  ingress_cidr_blocks = values(var.allowed_ips)
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}