class API
    BASE_URL = "https://rawg-video-games-database.p.rapidapi.com/games"
    KEY = ENV["API_KEY"]

    def self.get_games
        response = RestClient.get("#{BASE_URL}#{KEY}")
        data = JSON.parse(response.body)

        data["results"].each do |game|
            puts game["name"]
        end
        
        binding.pry
    end
end