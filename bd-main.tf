resource "google_sql_database_instance" "playlist-sql" {
  name             = "playlist-sql"
  database_version = "MYSQL_8_0"
  region           = "us-central1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "playlist" {
  name      = "playlist"
  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
}

resource "google_sql_user" "playlist_user" {
  name     = "spotmusicbackend"
  password = "$p@tmusic"
  host     = "%"
}
