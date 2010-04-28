CREATE TABLE movies (
  id         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  code       VARCHAR(255) UNIQUE NOT NULL,
  title      VARCHAR(255) NOT NULL,
  image_url  VARCHAR(255),
  image_path VARCHAR(255),
  year       INTEGER(4),
  votes      INTEGER,
  rating     FLOAT,
  outline    TEXT,
  credit     VARCHAR(255),
  genre      VARCHAR(255),
  runtime    FLOAT,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
  id       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name     VARCHAR(255) UNIQUE NOT NULL,
  selected INTEGER(1) NOT NULL DEFAULT 0
);

CREATE TABLE populars (
  movie_id INT NOT NULL REFERENCES movies(id),
  user_id  INT NOT NULL REFERENCES users(id),
  kind     INT NOT NULL,
  PRIMARY KEY(movie_id, user_id, kind)
);
