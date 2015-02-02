# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT
      artist
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    WHERE
      song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT
      artist
    FROM
      albums
    JOIN
      tracks ON tracks.album = albums.asin
    WHERE
      song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT
      song
    FROM
      tracks
    JOIN
      albums ON albums.asin = tracks.album
    WHERE
      title = 'Blur'


  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order by
  # the number of such tracks.
  execute(<<-SQL)
    SELECT
      title, COUNT(song)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    WHERE
      song LIKE '%Heart%'
    GROUP BY
      asin
    ORDER BY
      COUNT(song) DESC
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT
      title
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    WHERE
      song = title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT
      title
    FROM
      albums
    WHERE
      artist = title
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT
      song, COUNT(song)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    GROUP BY
      song
    HAVING
      COUNT(song) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT
      title, price, COUNT(song)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    GROUP BY
      asin
    HAVING
      price / COUNT(song) < .50
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
    SELECT
      title, COUNT(song)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    GROUP BY
      asin
    ORDER BY
      COUNT(song) DESC
    LIMIT 10
  SQL
end

def soundtrack_wars
  # Select the artist who has recorded the most soundtracks, as well as the
  # number of albums. HINT: use LIKE '%Soundtrack%' in your query.
  execute(<<-SQL)
    SELECT
      artist, COUNT(asin)
    FROM
      albums
    JOIN
      styles ON styles.album = albums.asin
    WHERE
      style LIKE '%Soundtrack%'
    GROUP BY
       artist
    ORDER BY
      count(asin) DESC
    LIMIT 1

  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  execute(<<-SQL)

    SELECT
      song_count_by_style.style, (total_price_by_style.sum_price / song_count_by_style.song_count) AS average
    FROM
      (SELECT
        style, COUNT(song) AS song_count
      FROM
        albums
      JOIN
        tracks ON albums.asin = tracks.album
      JOIN
        styles ON styles.album = albums.asin
      GROUP BY
        style) AS song_count_by_style
    JOIN
      (SELECT
        style, SUM(price) AS sum_price
      FROM
        albums
      JOIN
        styles ON styles.album = albums.asin
      WHERE
        price IS NOT NULL
      GROUP BY
        style) AS total_price_by_style
        ON song_count_by_style.style = total_price_by_style.style
    ORDER BY
      average DESC
    LIMIT 5

  SQL
end
