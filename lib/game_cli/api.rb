class API
    BASE_URL = "https://rawg-video-games-database.p.rapidapi.com/games?search="
    DETAIL_URL = "https://rawg-video-games-database.p.rapidapi.com/games/"
    authentication = 

    def self.get_games(game_title)
        title = game_title.gsub(" ", "%20") # replaces spaces with ASCII encoding for space

        response = RestClient.get("#{BASE_URL}#{title}", headers = {"x-rapidapi-host" => "rawg-video-games-database.p.rapidapi.com", "x-rapidapi-key" => ENV["API_KEY"]})
        data = JSON.parse(response.body)

        data["results"].each do |game|
            name = game["name"]
            slug = game["slug"]

            Game.new(name, slug)
        end
    end

    def self.get_game_details(game_selection)
        game = Game.all[game_selection.to_i - 1]
                       
        if game.description == nil
            response = RestClient.get("#{DETAIL_URL}#{game.slug}", headers = {"x-rapidapi-host" => "rawg-video-games-database.p.rapidapi.com", "x-rapidapi-key" => ENV["API_KEY"]})
            data = JSON.parse(response.body)

            game.description = data["description"]
            game.released = data["released"]
            game.metacritic_rating = data["metacritic"] unless data["metacritic"] == nil # default to 0 if no data

            data["ratings"].each do |rating|
                percent = rating["percent"]
                case rating["title"]
                when "recommended"
                    game.recommended_rating = percent # default to 0.0 if no data
                when "exceptional"
                    game.exceptional_rating = percent # default to 0.0 if no data
                when "meh"
                    game.meh_rating = percent # default to 0.0 if no data
                when "skip"
                    game.skip_rating = percent # default to 0.0 if no data
                end
            end
        end
    end
end