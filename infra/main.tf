locals {
  azs = ["${var.aws_region}a", "${var.aws_region}b"]
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  azs          = local.azs
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "${var.project_name}-eks"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
}
