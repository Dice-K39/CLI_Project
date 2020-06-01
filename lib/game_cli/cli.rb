class CLI
    def run
        welcome
        search_query
        main
    end

    def welcome
        puts "Welcome to the Game Search Command-line Interface using RAWG Video Games Database API."
    end

    def search_query
        puts "Please enter a game title that you would like information on or enter a word to see what games has that word in its title:"

        game_title = gets.chomp

        API.get_games(game_title)
    end

    def main
        print_games
        more_information
    end

    def print_games
        Game.sort_games
        Game.all.each.with_index(1) {|game, i| puts "#{i}. #{game.name}"}
    end

    def more_information
        puts "Select a number from the list to get more information:"

        game_selection = gets.chomp

        API.get_game_details(game_selection)
    end
end