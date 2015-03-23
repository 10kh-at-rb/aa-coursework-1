module TracksHelper
  def ugly_lyrics(lyrics)
    lyrics = lyrics.split("\n")


    html = "<pre>"
    lyrics.each do |lyric|
      html += "&#9835 "
      html += lyric
      html += "\n"
    end

    html += "</pre>"

    html.html_safe
  end
end
