class API
    URL = URI("https://rawg-video-games-database.p.rapidapi.com/")

    def self.get_games(game_title)
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new("#{URL}games?search=#{game_title}")
        request["x-rapidapi-host"] = 'rawg-video-games-database.p.rapidapi.com'
        request["x-rapidapi-key"] = ENV["API_KEY"]
        
        response = http.request(request)
        data = JSON.parse(response.body)
        
        data["results"].each do |game|
            name = game["name"]
            slug = game["slug"]

            Game.new(name, slug)
        end
    end

    def self.get_game_details(game_selection)
        if Game.all[game_selection.to_i - 1].description == nil
            http = Net::HTTP.new(URL.host, URL.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            request = Net::HTTP::Get.new("#{URL}games/#{Game.all[game_selection.to_i - 1].slug}")
            request["x-rapidapi-host"] = 'rawg-video-games-database.p.rapidapi.com'
            request["x-rapidapi-key"] = ENV["API_KEY"]
            
            response = http.request(request)
            data = JSON.parse(response.body)

            Game.all[game_selection.to_i - 1].description = data["description"]
            Game.all[game_selection.to_i - 1].released = data["released"]
            Game.all[game_selection.to_i - 1].metacritic_rating = data["metacritic"] unless data["metacritic"] == nil

            data["ratings"].each do |rating|
                case rating["title"]
                when "recommended"
                    Game.all[game_selection.to_i - 1].recommended_rating = rating["percent"] unless rating["percent"] == nil
                when "exceptional"
                    Game.all[game_selection.to_i - 1].exceptional_rating = rating["percent"] unless rating["percent"] == nil
                when "meh"
                    Game.all[game_selection.to_i - 1].meh_rating = rating["percent"] unless rating["percent"] == nil
                when "skip"
                    Game.all[game_selection.to_i - 1].skip_rating = rating["percent"] unless rating["percent"] == nil
                end
            end
        end
    end
end