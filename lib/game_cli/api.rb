class API
    URL = URI("https://rawg-video-games-database.p.rapidapi.com/games?search=\"Doom Eternal\"")

    def self.get_games
        search_key = gets.chomp
        http = Net::HTTP.new(URL.host, URL.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(URL)
        request["x-rapidapi-host"] = 'rawg-video-games-database.p.rapidapi.com'
        request["x-rapidapi-key"] = ENV["API_KEY"]
        
        response = http.request(request)
        data = JSON.parse(response.body)
        binding.pry
        data["results"].each.with_index(1) do |game, i|
            puts "#{i}. #{game["name"]}"
        end
    end
end