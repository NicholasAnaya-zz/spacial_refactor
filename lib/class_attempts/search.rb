class SearchApi
  def search_prompt_message
    puts
    puts "Enter a genre:"
    puts
  end

  def search_term(input)
    @search_term = input.split(" ").join("%20").downcase
  end

  def searching_message(input)
    puts
    puts "Your search term was '#{input}', I am searching the Spotify database. Please hold..."
    puts
  end
end


def search

  first_url = "http://api.spotify.com/v1/search?q=genre:#{@search_term}&limit=50&offset=0&type=artist"
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


# This block of code iterates over the final populated hash, (@@artist_hash), and organizes it using index + 1.
  def full_list
    @@artist_hash.each_with_index do |(artist, popularity_followers_hash), index |
      puts " #{index + 1}. #{artist}"
    end
  end



end
