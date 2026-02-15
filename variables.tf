variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the elsa k3s cluster"
  type        = string
}

variable "vultr_api_key" {
  description = "API key used to configure the Vultr provider"
  type        = string
  sensitive   = true
}

variable "live_image_tag" {
  description = "Image tag for the live deployment"
  type        = string
  default     = "live"
}

variable "staging_image_tag" {
  description = "Image tag for the staging deployment"
  type        = string
  default     = "staging"
}

variable "live_domain" {
  description = "Domain for the live deployment"
  type        = string
  default     = "soap.coffee"
}

variable "staging_domain" {
  description = "Domain for the staging deployment"
  type        = string
  default     = "staging.soap.coffee"
}
