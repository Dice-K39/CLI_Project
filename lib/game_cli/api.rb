class API
    URL = URI("https://rawg-video-games-database.p.rapidapi.com/games?search=")
    # URL = URI("https://rawg-video-games-database.p.rapidapi.com/games/doom-eternal")

    def self.get_games(game_title)
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new("#{URL}#{game_title}")
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
end