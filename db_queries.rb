require 'sqlite3'
require 'pry-byebug'
require 'colorize'

DB = SQLite3::Database.new('./chinook.sqlite')

def list_customers
	# return an array of customers with their name and emails
	DB.execute("SELECT first_name, last_name, email FROM customers;")
end

def list_classical_tracks
	# return an array of track names and composers of the Classical playlist
	DB.execute(%(SELECT tracks.name, tracks.composer FROM tracks JOIN playlist_tracks ON 
		tracks.id = playlist_tracks.track_id
		JOIN playlists ON 
		playlist_tracks.playlist_id = playlists.id WHERE playlists.name = 'Classical' 
		AND tracks.composer NOT LIKE '0';))
	# binding.pry
end

def top_ten_artists
	# return an array of the 10 most listed artists in all playlists
	result = DB.execute("
		SELECT artists.name, count(artists.name) AS artists_count FROM artists
		JOIN albums ON albums.artist_id = artists.id
		JOIN tracks ON tracks.album_id = albums.id
		JOIN playlist_tracks ON tracks.id = playlist_tracks.track_id
		ORDER BY artists_count DESC
		GROUP BY artists.name
		LIMIT 10
	")
end

def frequently_purchased_tracks
	# return an array of tracks that have been bought at least twice
	result = DB.execute("
		SELECT tracks.name, count(tracks.name) AS track_count FROM tracks
		JOIN invoice_lines ON tracks.id = invoice_lines.track_id
		GROUP BY tracks.name
		HAVING track_count >= 2
		ORDER BY track_count DESC
	")
end
