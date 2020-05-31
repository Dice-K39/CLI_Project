class CLI
    def run
        welcome
        search_parameter
    end

    def welcome
        puts "Welcome to the Game Search Command-line Interface using RAWG Video Games Database API."
    end

    def search_parameter
        puts "Please enter a game title that you would like information on:"

        game_title = gets.chomp

        API.get_games(game_title)
    end
end