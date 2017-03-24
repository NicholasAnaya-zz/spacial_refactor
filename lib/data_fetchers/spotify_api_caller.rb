class SpotifyApi
  attr_reader :url, :api_data

  @simplified_genres = ['Blues', 'Classical','Country','Electronic','Hip Hop','Industrial','Jazz','Pop','R&B','Rock','World']

  def initialize(url)
    @url = url
    @api_data = JSON.parse(RestClient.get("http://api.spotify.com/v1/search?q=genre:#{@search_term}&limit=50&offset=0&type=artist")
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
    all_artists = api_data["artists"]["items"]
    all_artists.each do |artist|
      make_artists
    genre_list =
  end





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
