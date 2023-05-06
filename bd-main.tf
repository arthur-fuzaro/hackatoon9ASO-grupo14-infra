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
  instance  = google_sql_database_instance.playlist-sql.name
  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
}

resource "google_sql_user" "playlist_user" {
  name     = "spotmusicbackend"
  password = "$p@tmusic"
  instance = google_sql_database_instance.playlist-sql.name
  host     = "%"
  port     = 3306
  database = "playlist"
}

resource "google_storage_bucket_object" "sql_script" {
  name   = "Playlist.sql"
  bucket = "playlist_bucket_grupo14"

  content = file("Playlist.sql")
}


resource "null_resource" "execute_script" {
  depends_on = [google_sql_user.playlist_user]

  provisioner "local-exec" {
    command = "PGPASSWORD=${MYSQL_PWD} psql -f Playlist.sql -p ${MYSQL_PORT} -U ${MYSQL_USERNAME} ${MYSQL_DATABASE}"
    environment = {
      MYSQL_PWD = google_sql_user.playlist_user.password
      MYSQL_PORT = google_sql_user.playlist_user.port
      MYSQL_USERNAME = google_sql_user.playlist_user.name
      MYSQL_DATABASE = google_sql_user.playlist_user.database
    }
  }
}
