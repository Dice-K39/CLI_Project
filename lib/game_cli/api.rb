class API
    URL = URI("https://rawg-video-games-database.p.rapidapi.com/")
    # URL = URI("https://rawg-video-games-database.p.rapidapi.com/games/doom-eternal")

    def self.get_games(game_title)
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new("#{URL}games?search=#{game_title}")
        request["x-rapidapi-host"] = 'rawg-video-games-database.p.rapidapi.com'
        request["x-rapidapi-key"] = ENV["API_KEY"]
        
        response = http.request(request)
        data = JSON.parse(response.body)
        
        data["results"].each.with_index(1) do |game, i|
            name = game["name"]
            slug = game["slug"]

            Game.new(name, slug)
        end
    end

    def self.get_game_details(game_selection)
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new("#{URL}games/#{Game.all[game_selection.to_i - 1].slug}")
        request["x-rapidapi-host"] = 'rawg-video-games-database.p.rapidapi.com'
        request["x-rapidapi-key"] = ENV["API_KEY"]
        
        response = http.request(request)
        data = JSON.parse(response.body)
        
        binding.pry

        Game.all[game_selection.to_i - 1].description = data["description"]
        Game.all[game_selection.to_i - 1].released = data["released"] 
        Game.all[game_selection.to_i - 1].metacritic_rating = data["metacritic_rating"]

        binding.pry
       
        Game.all[game_selection.to_i - 1].recommended_rating = data["ratings"][0]["percent"]
        Game.all[game_selection.to_i - 1].exceptional_rating = data["ratings"][1]["percent"]
        Game.all[game_selection.to_i - 1].meh_rating = data["ratings"][2]["percent"]
        Game.all[game_selection.to_i - 1].skip_rating = data["ratings"][3]["percent"]

        binding.pry
    end
end