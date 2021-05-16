data "aws_eks_cluster" "cluster" {
  name = module.kubernetes.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.kubernetes.cluster_name
}

locals {
  environment  = var.environment
  project      = var.project
  cluster_name = var.cluster_name
  domain       = ["${local.cluster_name}.${var.domain_name}"]
}

module "network" {
  source = "github.com/provectus/sak-vpc"

  availability_zones = var.availability_zones
  environment        = local.environment
  project            = local.project
  cluster_name       = local.cluster_name
  network            = 10
}

module "kubernetes" {
  depends_on = [module.network]
  source     = "github.com/provectus/sak-kubernetes"

  environment        = local.environment
  project            = local.project
  availability_zones = var.availability_zones
  cluster_name       = local.cluster_name
  vpc_id             = module.network.vpc_id
  subnets            = module.network.private_subnets

  on_demand_gpu_instance_type = "g4dn.xlarge"
}

module "fluxcd" {
  source              = "github.com/BulbaWarrior/sak-incubator/cicd/fluxcd"
  depends_on          = [module.kubernetes]
  git_url             = var.fluxcd.git_url
  git_branch          = var.fluxcd.branch
  namespace           = var.fluxcd.namespace
  provision_namespace = var.fluxcd.provision_namespace
}
