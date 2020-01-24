


query_3 = %(
	SELECT artists.name, count(playlist_tracks.track_id) AS count FROM artists
	JOIN albums ON albums.artist_id = artists.id
	JOIN tracks ON tracks.album_id = albums.id
	JOIN playlist_tracks ON playlist_tracks.track_id = tracks.id
	JOIN playlists ON playlists.id = playlist_tracks.playlist_id
	ORDER BY count DESC
	GROUP BY artists.name
	LIMIT 10
)

query_4 = %(
	SELECT tracks.name, count(tracks.name) AS count FROM tracks
	JOIN invoice_lines ON invoice_lines.track_id = tracks.id
	GROUP BY invoice_lines.track_id
	HAVING count >= 2
)