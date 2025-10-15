# locals {
#   azs = ["${var.aws_region}a", "${var.aws_region}b"]
# }

# module "vpc" {
#   source          = "./modules/vpc"
#   project_name    = var.project_name
#   vpc_cidr        = var.vpc_cidr
#   public_subnets  = var.public_subnets
#   private_subnets = var.private_subnets
#   azs             = var.azs
# }


# module "eks" {
#   source       = "./modules/eks"
#   cluster_name = "${var.project_name}-eks"
#   vpc_id       = module.vpc.vpc_id
#   subnet_ids   = module.vpc.private_subnets
# }
