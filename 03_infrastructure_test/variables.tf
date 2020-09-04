variable "region" {
  description = "The region to provision all AWS resources"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_name" {
  description = "The VPC name to use for all the cluster resources"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "instance_type" {
  description = "The type of instance to start."
  type        = string
}

variable "allowed_ips" {
  description = "A map of allowed /32 ips authorized to ssh into bastion"
  default     = {} # by default don't allow any ips
}

variable "lc_name" {
  description = "Name of the launch configuration the auto scaling group uses to provision our bastion server"
  type        = string
}