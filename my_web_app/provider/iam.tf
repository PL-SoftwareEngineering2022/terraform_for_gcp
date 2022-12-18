locals {
  sa_roles = [
    "roles/compute.networkUser",
    "roles/containerregistry.ServiceAgent",
    "roles/container.admin",
    "roles/container.nodeServiceAccount",
    "roles/container.nodeServiceAgent",
    "roles/storage.objectViewer",
    "roles/iam.workloadIdentityUser",
    "roles/compute.instanceAdmin",
    "roles/storage.admin",
  ]

  api_services = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "redis.googleapis.com",
    "storage.googleapis.com",
  ]
}
resource "google_service_account" "web_app_project_sa" {
  account_id   = "webappproject"
  display_name = "service account for webapp project"
  project      = var.project
}

resource "google_project_iam_member" "webappproject_binding" {
  project  = var.project
  for_each = toset(local.sa_roles)
  role     = each.value
  member   = "serviceAccount:${google_service_account.web_app_project_sa.email}"

}

resource "google_project_service" "project" {
  project            = var.project
  for_each           = toset(local.api_services)
  service            = each.value
  disable_on_destroy = false
}