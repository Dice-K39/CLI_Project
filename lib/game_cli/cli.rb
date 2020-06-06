class CLI
    def run
        welcome
        main
    end

    def main
       game_information_start
    end

    def welcome
        puts "============================================================================================"
        puts "Welcome to the Video Game Search Command-line Interface using RAWG Video Games Database API."
        puts "============================================================================================"
    end

    def game_information_start
        selection = ""

        loop do
            if selection == "new"
                Game.clear
            end

            search_query if Game.all.empty?
            print_games if Game.all.any?
            more_information
            return_to_list_or_new_search_or_exit

            # mini do while loop
            loop do
                selection = gets.chomp

                # ternary operator to break out or print selection not an option
                selection == "new" || selection == "list" || selection == "exit" ? break : print_selection_not_an_option
            end

            if selection == "exit"
                break
            end
        end
    end

    def search_query
        until Game.all.any?
            puts "\nPlease enter a game title that you would like information on or enter a word to see what games has that word in its title:"

            game_title = gets.chomp

            API.get_games(game_title)
        end
    end

    def print_games
        Game.all.each.with_index(1) {|game, i| puts "#{i}".blue + ". #{game.name}"}
    end

    def more_information
        puts "Select a number from the list to get more information about the game:"

        game_selection = gets.chomp

        puts ""

        API.get_game_details(game_selection)
        print_game_details(game_selection)
    end

    def print_game_details(game_selection)
        puts "Game Title:".red + "\n#{Game.all[game_selection.to_i - 1].name}"
        puts "Game Description:".red + "\n#{Game.all[game_selection.to_i - 1].description}"
        puts "Release Date:".red + "\n#{Game.all[game_selection.to_i - 1].released}"
        puts "Metacrtic Rating:".red + "\n#{Game.all[game_selection.to_i - 1].metacritic_rating} out of 100"
        puts "Player Ratings:".red
        puts "\tRecommended:".red + " #{Game.all[game_selection.to_i - 1].recommended_rating}%"
        puts "\tExceptional:".red + " #{Game.all[game_selection.to_i - 1].exceptional_rating}%"
        puts "\t   Mediocre:".red + " #{Game.all[game_selection.to_i - 1].meh_rating}%"
        puts "\tNo Interest:".red + " #{Game.all[game_selection.to_i - 1].skip_rating}%"
    end

    def return_to_list_or_new_search_or_exit
        puts "Would you like to go back to the game list, start a new search, or exit?"
        puts "Type \"list\", \"new\", or \"exit\""
    end

    def print_selection_not_an_option
        puts "Please enter \"new\" for new search, \"list\" to return to list, or \"exit\" to exit program."
    end
end