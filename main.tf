resource "helm_release" "soap_coffee_live" {
  name  = "soap-coffee-live"
  chart = "${path.module}/charts/soap-coffee"

  set = [
    {
      name  = "image.tag"
      value = var.live_image_tag
    },
    {
      name  = "domain"
      value = var.live_domain
    },
  ]
}

resource "helm_release" "soap_coffee_staging" {
  name  = "soap-coffee-staging"
  chart = "${path.module}/charts/soap-coffee"

  set = [
    {
      name  = "image.tag"
      value = var.staging_image_tag
    },
    {
      name  = "domain"
      value = var.staging_domain
    },
    {
      name  = "staging"
      value = "true"
    },
  ]
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

  set_sensitive = [
    {
      name  = "password"
      value = random_password.postgresql_superuser.result
    },
    {
      name  = "ext-postgres-operator.postgres.password"
      value = random_password.postgresql_superuser.result
    },
  ]
}

resource "helm_release" "miniflux" {
  name  = "miniflux"
  chart = "${path.module}/charts/miniflux"

  depends_on = [helm_release.postgresql]

  set_sensitive = [
    {
      name  = "admin.password"
      value = random_password.miniflux_admin.result
    },
  ]
}

resource "random_password" "soju_admin" {
  length  = 32
  special = false
}

resource "helm_release" "soju" {
  name  = "soju"
  chart = "${path.module}/charts/soju"

  depends_on = [helm_release.postgresql]

  set_sensitive = [
    {
      name  = "admin.password"
      value = random_password.soju_admin.result
    },
  ]
}

resource "random_password" "n8n_encryption_key" {
  length  = 32
  special = false
}

resource "helm_release" "n8n" {
  name  = "n8n"
  chart = "${path.module}/charts/n8n"

  depends_on = [helm_release.postgresql]

  set_sensitive = [
    {
      name  = "encryptionKey"
      value = random_password.n8n_encryption_key.result
    },
  ]
}

resource "random_password" "conduwuit_registration_token" {
  length  = 32
  special = false
}

resource "random_password" "conduwuit_admin" {
  length  = 32
  special = false
}

resource "helm_release" "conduwuit" {
  name  = "conduwuit"
  chart = "${path.module}/charts/conduwuit"

  set_sensitive = [
    {
      name  = "registrationToken"
      value = random_password.conduwuit_registration_token.result
    },
    {
      name  = "admin.password"
      value = random_password.conduwuit_admin.result
    },
  ]
}

resource "random_id" "garage_rpc_secret" {
  byte_length = 32
}

resource "random_password" "garage_admin_token" {
  length  = 32
  special = false
}

resource "random_id" "garage_s3_access_key" {
  byte_length = 12
}

resource "random_id" "garage_s3_secret_key" {
  byte_length = 32
}

locals {
  garage_s3_access_key = "GK${random_id.garage_s3_access_key.hex}"
  garage_s3_secret_key = random_id.garage_s3_secret_key.hex
}

resource "helm_release" "garage" {
  name  = "garage"
  chart = "${path.module}/charts/garage"

  wait_for_jobs = true

  set_sensitive = [
    {
      name  = "garage.rpcSecret"
      value = random_id.garage_rpc_secret.hex
    },
    {
      name  = "garage.adminToken"
      value = random_password.garage_admin_token.result
    },
    {
      name  = "garage.s3AccessKey"
      value = local.garage_s3_access_key
    },
    {
      name  = "garage.s3SecretKey"
      value = local.garage_s3_secret_key
    },
  ]
}

output "garage_admin_token" {
  value     = random_password.garage_admin_token.result
  sensitive = true
}

output "garage_s3_access_key" {
  value     = local.garage_s3_access_key
  sensitive = true
}

output "garage_s3_secret_key" {
  value     = local.garage_s3_secret_key
  sensitive = true
}

output "conduwuit_registration_token" {
  value     = random_password.conduwuit_registration_token.result
  sensitive = true
}

output "conduwuit_admin_password" {
  value     = random_password.conduwuit_admin.result
  sensitive = true
}

output "miniflux_admin_password" {
  value     = random_password.miniflux_admin.result
  sensitive = true
}

output "soju_admin_password" {
  value     = random_password.soju_admin.result
  sensitive = true
}
