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

resource "random_password" "postgresql_superuser" {
  length  = 32
  special = false
}

resource "random_password" "miniflux_admin" {
  length  = 32
  special = false
}

resource "helm_release" "postgresql" {
  name  = "postgresql"
  chart = "${path.module}/charts/postgresql"

  set_sensitive {
    name  = "password"
    value = random_password.postgresql_superuser.result
  }

  set_sensitive {
    name  = "ext-postgres-operator.postgres.password"
    value = random_password.postgresql_superuser.result
  }
}

resource "helm_release" "miniflux" {
  name  = "miniflux"
  chart = "${path.module}/charts/miniflux"

  depends_on = [helm_release.postgresql]

  set_sensitive {
    name  = "admin.password"
    value = random_password.miniflux_admin.result
  }
}

resource "random_password" "soju_admin" {
  length  = 32
  special = false
}

resource "helm_release" "soju" {
  name  = "soju"
  chart = "${path.module}/charts/soju"

  depends_on = [helm_release.postgresql]

  set_sensitive {
    name  = "admin.password"
    value = random_password.soju_admin.result
  }
}

output "miniflux_admin_password" {
  value     = random_password.miniflux_admin.result
  sensitive = true
}

output "soju_admin_password" {
  value     = random_password.soju_admin.result
  sensitive = true
}
