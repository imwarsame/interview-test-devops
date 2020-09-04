vpc_name       = "03-infrastructure-test"
cidr           = "10.20.0.0/16"
azs            = ["eu-west-1a", "eu-west-1b"]
public_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
instance_type  = "t2.micro"
lc_name        = "03-infrastructure-test-lc"
allowed_ips = {
  warsame = "x.x.x.x.x.x/32"
}