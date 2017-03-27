class SpotifyApi
  attr_reader :url, :api_data

  @simplified_genres = ['Blues', 'Classical','Country','Electronic','Hip Hop','Industrial','Jazz','Pop','R&B','Rock','World']
  @user_input =

  def initialize(url)
    @url = url
    @api_data = JSON.parse(RestClient.get(@url))
  end

  def make_artists
    artist_hash = {}
    all_artists = @api_data["artists"]["items"]
    all_artists.each do |artist|
      artist_name = artist["name"]
      artist_hash[artist_name] = {}
    end
    artist_hash
  end

  def make_related_genres
    genre_hash = {}
    all_artists = @api_data["artists"]["items"]
    all_artists.each do |artist|
      artist_name = artist["name"]
      genre_array = artist["genres"]
      genre_hash[artist_name] = {"genres" => genre_array}
    end
    genre_hash
  end


  {
    "artists": {
      "href": "https://api.spotify.com/v1/search?query=genre%3Arock&type=artist&offset=0&limit=50",
      "items": [ {"external_urls": {"spotify": "https://open.spotify.com/artist/3WrFJ7ztbogyGnTHbHJFl2"},
                  "followers": {
                    "href": null,
                    "total": 2966527
                  },
                  "genres": [
                    "british invasion",
                    "classic rock",
                    "merseybeat",
                    "protopunk",
                    "psychedelic rock",
                    "rock"
                  ],
                  "href": "https://api.spotify.com/v1/artists/3WrFJ7ztbogyGnTHbHJFl2",
                  "id": "3WrFJ7ztbogyGnTHbHJFl2",
                  "images": [
                        {
                          "height": 1000,
                          "url": "https://i.scdn.co/image/934c57df9fbdbbaa5e93b55994a4cb9571fd2085",
                          "width": 1000
                        },
                        {
                          "height": 640,
                          "url": "https://i.scdn.co/image/5f70d98d3e4616a02a3afe2aa9a840b9157b92a1",
                          "width": 640
                        },
                        {
                          "height": 200,
                          "url": "https://i.scdn.co/image/7fe1a693adc52e274962f1c61d76ca9ccc62c191",
                          "width": 200
                        },
                        {
                          "height": 64,
                          "url": "https://i.scdn.co/image/857b1ce5b1b372b873b0a8bdb3ff8023b6c61d39",
                          "width": 64
                        }
                  ],
                  "name": "The Beatles",
                  "popularity": 82,
                  "type": "artist",
                  "uri": "spotify:artist:3WrFJ7ztbogyGnTHbHJFl2"
                }




while api_data["artists"]["next"]


def search
  @search_term = input.split(" ").join("%20").downcase

  url = "http://api.spotify.com/v1/search?q=genre:#{@search_term}&limit=50&offset=0&type=artist"

  first_url_artist_data_raw = RestClient.get(first_url)
  result = JSON.parse(first_url_artist_data_raw)
  artist_information_array = result["artists"]["items"]

  while result["artists"]["next"]
    artist_data_raw = RestClient.get(result["artists"]["next"])
    result = JSON.parse(artist_data_raw)
    artist_information_array += result["artists"]["items"]
end




  puts "Found artists...sorting..."
  puts


  artist_information_array.each do | attribute_hash |
          each_artist_name = attribute_hash["name"]
          @@artist_hash[each_artist_name] ||= {}
          @@artist_hash[each_artist_name][:popularity] = attribute_hash["popularity"]
          @@artist_hash[each_artist_name][:followers] = attribute_hash["followers"]["total"]
  end
# ***

  puts "Thank you for your patience. Here is a list of all '#{@search_term.capitalize}' artists on Spotify:"
  puts

# ***
# This block of code iterates over the final populated hash, (@@artist_hash), and organizes it using index + 1.
# Outputs full list
  @@artist_hash.each_with_index do |(artist, popularity_followers_hash), index |
    puts " #{index + 1}. #{artist}"
  end
end
