provider "aws" {
  region = var.region
}

locals {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "kubernetes" {
  host                   = local.host
  cluster_ca_certificate = local.cluster_ca_certificate
  token                  = local.token
  load_config_file       = local.load_config_file
}

provider "kubectl" {
  host                   = local.host
  cluster_ca_certificate = local.cluster_ca_certificate
  token                  = local.token
  load_config_file       = local.load_config_file
}

provider "helm" {
  kubernetes {
    host                   = local.host
    cluster_ca_certificate = local.cluster_ca_certificate
    token                  = local.token
    load_config_file       = local.load_config_file
  }
}
