terraform {
  cloud {
    organization = "lthms"

    workspaces {
      name = "lthms-cloud-lab"
    }
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    vultr = {
      source  = "vultr/vultr"
      version = "2.29.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
}
