variable "vpc_cidr_block" {
  default = "10.10.11.0/28"
}

variable "vpc_name" {
  default = "dev_ops_vpc"
}

variable "public_subnet" {
  default = ["10.10.11.0/28"]
}

variable "dev_ops_tags" {
  description = "Tags dev_ops_cours"
  type        = map(string)
  default = {
    terraform = "true"
    project   = "dev_ops_cours"
  }
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["eu-west-2a"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "private_key_path" {
  description = "Path to private key as string"
  default     = "/home/statys/.ssh/id_rsa"
}