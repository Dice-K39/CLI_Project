class CLI
    def run
        welcome
        main
    end

    def welcome
        puts "Welcome to the Game Search Command-line Interface using RAWG Video Games Database API."
    end

    def main
        selection = ""

        until selection == "exit"
            if selection == "new"
                Game.clear
            end

            search_query if selection == "new" || Game.all.empty?
            print_games if selection == "list" || selection == "new" || Game.all.any?
            more_information
            return_to_list_or_new_search_or_exit

            selection = ""

            until selection == "new" || selection == "list" || selection == "exit"
                selection = gets.chomp
binding.pry
                selection_not_an_option(selection)
            end
        end
    end

    def search_query
        puts "Please enter a game title that you would like information on or enter a word to see what games has that word in its title:"

        game_title = gets.chomp

        API.get_games(game_title)
    end

    def print_games
        Game.sort_games
        Game.all.each.with_index(1) {|game, i| puts "#{i}. #{game.name}"}
    end

    def more_information
        puts "Select a number from the list to get more information about the game:"

        game_selection = gets.chomp

        API.get_game_details(game_selection)
        print_game_details(game_selection)
    end

    def print_game_details(game_selection)
        puts "Game Title:\n#{Game.all[game_selection.to_i - 1].name}"
        puts "Game Description:\n#{Game.all[game_selection.to_i - 1].description}"
        puts "Metacrtic Rating:\n#{Game.all[game_selection.to_i - 1].metacritic_rating} out of 100"
        puts "Ratings:"
        puts "\tRecommended: #{Game.all[game_selection.to_i - 1].recommended_rating}%"
        puts "\tExceptional: #{Game.all[game_selection.to_i - 1].exceptional_rating}%"
        puts "\t   Mediocre: #{Game.all[game_selection.to_i - 1].meh_rating}%"
        puts "\tNo Interest: #{Game.all[game_selection.to_i - 1].skip_rating}%"
    end

    def return_to_list_or_new_search_or_exit
        puts "Would you like to go back to the game list, start a new search, or exit?"
        puts "Type \"list\", \"new\", or \"exit\""
    end

    def selection_not_an_option(selection)
        if selection != "new" || selection != "list" || selection != "exit"
            binding.pry
            puts "Please enter \"new\" for new search, \"list\" to return to list, or \"exit\" to exit program."
        end
    end
end