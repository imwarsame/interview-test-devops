vpc_name       = "03-infrastructure-test"
cidr           = "10.20.0.0/16"
azs            = ["eu-west-1a", "eu-west-1b"] # 2 az required by rds subnet group, and alb
public_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
instance_type  = "t2.micro"
allowed_ips = {
  warsame = "x.x.x.x.x.x/32"
}