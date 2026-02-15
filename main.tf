resource "helm_release" "soap_coffee_live" {
  name  = "soap-coffee-live"
  chart = "${path.module}/charts/soap-coffee"

  set {
    name  = "image.tag"
    value = var.live_image_tag
  }

  set {
    name  = "domain"
    value = var.live_domain
  }
}

resource "helm_release" "soap_coffee_staging" {
  name  = "soap-coffee-staging"
  chart = "${path.module}/charts/soap-coffee"

  set {
    name  = "image.tag"
    value = var.staging_image_tag
  }

  set {
    name  = "domain"
    value = var.staging_domain
  }

  set {
    name  = "staging"
    value = "true"
  }
}
