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
  instance  = google_sql_database_instance.playlist-sql.name
  host     = "%"
}

resource "google_storage_bucket_object" "sql_script" {
  name   = "Playlist.sql"
  bucket = "playlist_bucket_grupo14"

  content = file("Playlist.sql")
}


resource "null_resource" "execute_script" {
  depends_on = [google_sql_user.playlist_user]

  provisioner "local-exec" {
    command = "cat Playlist.sql | mysql -u ${google_sql_user.playlist_user.name} -h ${google_sql_database_instance.playlist-sql.ip_address} -p${google_sql_user.playlist_user.password} ${google_sql_database.playlist.name}"
    environment = {
      MYSQL_PWD = google_sql_user.playlist_user.password
    }
  }
}
