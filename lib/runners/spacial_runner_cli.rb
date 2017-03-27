class SpacialRunnerCLI

  def call
    puts "Welcometo SPACIAL, what genre should I look up?"
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "New genre search keyword: "
    input = get_user_input
    if input == "help"
      help
    elsif input == "exit"
      exit
    else
      search(input)
    end
    run
  end

  def search
    search_term = input.split(" ").join("%20").downcase
    puts "You are searching for #{input.capitalize}, searching..."
    url = "http://api.spotify.com/v1/search?q=genre:#{@search_term}&limit=50&offset=0&type=artist"


    artists = SpotifyApi.new(url).make_artists
    result = JSON.parse(first_url_artist_data_raw)
    artist_information_array = result["artists"]["items"]

    while result["artists"]["next"]
      artist_data_raw = RestClient.get(result["artists"]["next"])
      result = JSON.parse(artist_data_raw)
      artist_information_array += result["artists"]["items"]
  end



  @@popularity_array = []
  @@artist_hash = {}
  @@simplified_genres = ['Blues', 'Classical','Country','Electronic','Hip Hop','Industrial','Jazz','Pop','R&B','Rock','World']

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

  def welcome
    @welcome = WelcomeMessage.new
    @welcome.text
  end

  def help
    @help = Help.new
    @help.text
  end

  def get_user_input
    gets.chomp.strip
  end


  def run
   @help.text
   puts
   input = ""

   input = get_user_input

    if input == "help"
      @help.text
      puts
      run
    elsif input == "exit"
      @thank_you = ThankYou.new
      @thank_you.text
      exit
    elsif input == "search"

      @input = get_user_input.downcase
          # if @@simplified_genres.include?(@input.capitalize)
          if @input

            search

            after_search_query

            popularity_filter

            puts
            puts "Wow! Your list of #{@search_term} artists is now sorted!"
            puts
            puts
            puts "If you would like to start again, enter 'restart'"
            puts "If you would like to exit, enter 'exit'"
            puts

            @input = get_user_input

            if @input == "restart"
              @@artist_hash.clear
              run
            elsif @input == "exit"
              puts
              puts "Thank you for using SPACIAL. See you next time!"
              puts

              exit
            end

          else
            puts
            puts "That doesn't seem to be a genre in our system"
            puts "Check searchable genres by entering 'genre'"
            puts
          end

          @input = get_user_input

          if @input == 'genre'
            list_genres_method

            run
          end

        elsif input == "genre"
          list_genres_method

          run
        else
          puts
          puts "Oops! It looks like '#{input}' is not a valid command."
          puts

          help
        end
  end

  def list_genres_method
    puts
    puts "Here is a list of searchable genres"
    puts
    puts "*" * 60
    puts @@simplified_genres.join(", ")
    puts "*" * 60
    puts
  end

  def input
    @input
  end

  def after_search_query
    puts
    puts "Wow! What a great list of #{@search_term.capitalize} artists!"

  end


# ***

# I did not touch the below popularity filter since _ spent most of my time re-formatting the above
# I think variables will have to be changed here based on the above
# I tried to make things more specific so variables are easy to understand at a glance
def popularity_filter
  puts
  puts "Artist popularity is measured from 1-100. Please enter a popularity"
  puts "     Please separate your numbers by a dash ('i.e. 40-80')"
  puts "Output will demonstrate popularity metric and follower number"
  puts
    @input = get_user_input

    input_array = input.strip.split("-")

    # if input_array.all? { |num_input| user_num = Integer(num_input) rescue false }
      popularity_input_one = input_array[0].to_i
      popularity_input_two = input_array[1].to_i
      #Input is a string, so has to be change to an integer
      most_popular = sort_hash_by_popularity.last[1][:popularity]
      least_popular = sort_hash_by_popularity.first[1][:popularity]

      if most_popular < popularity_input_one || least_popular > popularity_input_two
        puts
        puts "Sorry! that search is out of range. Please try again"
        popularity_filter

      else
        puts
        puts "Returning all artists with a popularity between #{popularity_input_one} and #{popularity_input_two}"
        puts
        puts

        sort_hash_by_popularity.each do | artist, popularity_followers_hash |
          popularity_followers_hash.each do |attribute, num|
            if attribute == :popularity
              if num >= popularity_input_one && num <= popularity_input_two
                puts "#{artist}: #{popularity_followers_hash.to_s.delete("{}:=").gsub!(/[>]/, '= ')}"
                puts
              end
            end
          end
        end
      end

    # else
    #   puts
    #   puts "Error: Please enter an number"
    #
    #   popularity_filter
    # end
    # input.gsub!(/[\s, :><+=]/, '-')
 end

   def sort_hash_by_popularity
     @@artist_hash.sort_by do | artist, popularity_followers_hash|
       popularity_followers_hash[:popularity]
     end
   end

end
