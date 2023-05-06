resource "google_artifact_registry_repository" "spotmusic-backend-repo" {
  location = var.region
  repository_id = "spotmusic-backend"
  description = "Imagens Docker do backend da spot music"
  format = "DOCKER"
}

resource "google_artifact_registry_repository" "spotmusic-frontend-repo" {
  location = var.region
  repository_id = "spotmusic-frontend"
  description = "Imagens Docker do Frontend da spot music"
  format = "DOCKER"
}