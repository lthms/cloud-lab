terraform {
  cloud {
    organization = "lthms"

    workspaces {
      name = "lthms-cloud-lab"
    }
  }

  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.29.1"
    }
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
}
