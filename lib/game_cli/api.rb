class API
    BASE_URL = "https://rawg-video-games-database.p.rapidapi.com/games?search="
    DETAIL_URL = "https://rawg-video-games-database.p.rapidapi.com/games/"

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
        if Game.all[game_selection.to_i - 1].description == nil
            response = RestClient.get("#{DETAIL_URL}#{Game.all[game_selection.to_i - 1].slug}", headers = {"x-rapidapi-host" => "rawg-video-games-database.p.rapidapi.com", "x-rapidapi-key" => ENV["API_KEY"]})
            data = JSON.parse(response.body)

            Game.all[game_selection.to_i - 1].description = data["description"]
            Game.all[game_selection.to_i - 1].released = data["released"]
            Game.all[game_selection.to_i - 1].metacritic_rating = data["metacritic"] unless data["metacritic"] == nil # default to 0 if no data

            data["ratings"].each do |rating|
                case rating["title"]
                when "recommended"
                    Game.all[game_selection.to_i - 1].recommended_rating = rating["percent"] unless rating["percent"] == nil # # default to 0.0 if no data
                when "exceptional"
                    Game.all[game_selection.to_i - 1].exceptional_rating = rating["percent"] unless rating["percent"] == nil # # default to 0.0 if no data
                when "meh"
                    Game.all[game_selection.to_i - 1].meh_rating = rating["percent"] unless rating["percent"] == nil # # default to 0.0 if no data
                when "skip"
                    Game.all[game_selection.to_i - 1].skip_rating = rating["percent"] unless rating["percent"] == nil # # default to 0.0 if no data
                end
            end
        end
    end
end