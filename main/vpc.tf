#odule "vpc" {
# source = "terraform-aws-modules/vpc/aws"
#
# name = "${var.project}-vpc"
# cidr = "10.0.0.0/16"
#
# azs = [
#   "${data.aws_availability_zones.zones.names[0]}",
#   "${data.aws_availability_zones.zones.names[1]}",
#   "${data.aws_availability_zones.zones.names[2]}"
# ]
# private_subnets = [
#   "10.0.1.0/24",
#   "10.0.2.0/24",
#   "10.0.3.0/24"
# ]
# public_subnets = [
#   "10.0.101.0/24",
#   "10.0.102.0/24",
#   "10.0.103.0/24"
# ]
#
# enable_nat_gateway      = true
# enable_vpn_gateway      = true
# map_public_ip_on_launch = true
# tags = {
#   Terraform = "true"
# }
#

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_availability_zones.zones.names[0]}", "${data.aws_availability_zones.zones.names[1]}", "${data.aws_availability_zones.zones.names[2]}"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway      = true
  enable_vpn_gateway      = true
  map_public_ip_on_launch = true

  tags = {
    Terraform                             = "true"
    "kubernetes.io/cluster/flask-cluster" = "shared"
    "kubernetes.io/role/elb"              = "1"
  }
}
