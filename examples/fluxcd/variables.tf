variable "cluster_name" {
  default     = "swiss-army-kube"
  type        = string
  description = "A name of the Amazon EKS cluster"
}

variable "region" {
  default     = "eu-north-1"
  type        = string
  description = "Set default region"
}

variable "availability_zones" {
  default     = ["eu-north-1a", "eu-north-1b"]
  type        = list(any)
  description = "Availability zones for project"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "A value that will be used in annotations and tags to identify resources with the `Environment` key"
}

variable "project" {
  default     = "SWISS"
  type        = string
  description = "A value that will be used in annotations and tags to identify resources with the `Project` key"
}

variable "domain_name" {
  default     = "swiss.sak.ninja"
  type        = string
  description = "Default domain name"
}

variable "fluxcd" {
  default = {
    git_url             = "git@github.com:BulbaWarrior/flux-get-started"
    branch              = "master"
    namespace           = "flux"
    provision_namespace = true
  }
  type        = map(any)
  description = "A set of values for enabling deployment through fluxcd"
}
