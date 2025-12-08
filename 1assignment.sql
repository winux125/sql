-- ==========================
--  USERS
-- ==========================
CREATE TABLE "User" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    subscription_type VARCHAR(50) DEFAULT 'free',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================
--  ARTISTS
-- ==========================
CREATE TABLE Artist (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(255) NOT NULL,
    bio TEXT
);

-- ==========================
--  GENRES
-- ==========================
CREATE TABLE Genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL UNIQUE
);

-- ==========================
--  ALBUMS
-- ==========================
CREATE TABLE Album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    artist_id INT NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

-- ==========================
--  SONGS
-- ==========================
CREATE TABLE Song (
    song_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INT,
    release_date DATE,
    url TEXT,
    artist_id INT NOT NULL,
    album_id INT,
    genre_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id),
    FOREIGN KEY (album_id) REFERENCES Album(album_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- ==========================
--  PLAYLISTS
-- ==========================
CREATE TABLE Playlist (
    playlist_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id)
);

-- ==========================
--  PLAYLIST_SONG  (Many-to-Many)
-- ==========================
CREATE TABLE Playlist_Song (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES Song(song_id) ON DELETE CASCADE
);

-- ==========================
--  STREAMING HISTORY
-- ==========================
CREATE TABLE Streaming_History (
    history_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id),
    FOREIGN KEY (song_id) REFERENCES Song(song_id)
);

-- ==========================
--  LIKES (User ↔ Song)
-- ==========================
CREATE TABLE User_Like (
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, song_id),
    FOREIGN KEY (user_id) REFERENCES "User"(user_id),
    FOREIGN KEY (song_id) REFERENCES Song(song_id)
);

-- ==========================
--  ARTIST FOLLOWERS (User ↔ Artist)
-- ==========================
CREATE TABLE Artist_Follower (
    user_id INT NOT NULL,
    artist_id INT NOT NULL,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, artist_id),
    FOREIGN KEY (user_id) REFERENCES "User"(user_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);
