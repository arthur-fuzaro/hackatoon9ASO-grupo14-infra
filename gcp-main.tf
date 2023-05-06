resource "google_artifact_registry_repository" "spotmusic-backend-repo" {
  location = var.region
  repository_id = "spotMusic-Backend"
  description = "Imagens Docker do backend da spot music"
  format = "DOCKER"
}

resource "google_artifact_registry_repository" "spotmusic-frontend-repo" {
  location = var.region
  repository_id = "spotMusic-Frontend"
  description = "Imagens Docker do Frontend da spot music"
  format = "DOCKER"
}