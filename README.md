# CLI_Project

This application is for the Flatiron CLI Data Gem Portfolio Project. This application will be using the RAWG Video Games Database API to get detailed information about popular games of all platforms.

# Getting Started

You will need these gems to get this application to work properly:

    gem "rest-client"
    gem "json"
    gem "colorize"

To install these gems type "bundle install" in your terminal or type gem get "gem_name" to install them individually. 

Also you will need an API key from https://www.rapidapi.com. Register for the site. Then search for RAWG Video Games Database on the search bar to find the api quickly. Once you are in the RAWG API section, you will find the API key in the middle section under the "Header Parameters." If you do not want to type it in you, you will be able to copy it from the code snippet on the right side.

# Running the Application

Type bin/run from the application's main folder to start the application. 

    ~/.../Projects/CLI_Project // ♥ > bin/run

Then it will prompt you with a greeting and a question of what you games you want to search for.

    Welcome to the Game Search Command-line Interface using RAWG Video Games Database API.
    Please enter a game title that you would like information on or enter a word to see what games has that word in its title:

You will see a list of games numbered.

    Please enter a game title that you would like information on or enter a word to see what games has that word in its title:
    super mario
    1. Super mario(itch)
    2. Super Mario Bros.
    3. Super Mario 64
    4. Super Mario Strikers
    5. Super Mario World
    6. Super Mario Kart
    7. Super Mario Bros. 2
    8. Super Mario All-Stars (1993)
    9. Super Mario Bros. 3
    10. Super Mario Bros.: The Lost Levels
    11. Wario Land: Super Mario Land 3
    12. Super Mario World 2: Yoshi's Island
    13. Super Mario RPG: Legend of the Seven Stars
    14. Super Mario Land 2: 6 Golden Coins
    15. Super Mario Maker
    16. Super Mario Odyssey
    17. Super Mario Land
    18. Super Mario Sunshine
    19. New Super Mario Bros.
    20. Super Mario Run
    Select a number to see detailed information about that game:

Select a number to see detailed information about the chosen game.

    2
    Game Title:
    Super Mario Bros.
    Game Description:
    <p>Mario and Luigi star in their first ever Mushroom Kingdom adventure! Find out why Super Mario Bros. is instantly recognizable to millions of people across the globe, and what made it the best-selling game in the world for three decades straight. Jump over obstacles, grab coins, kick shells, and throw fireballs through eight action-packed worlds in this iconic NES classic. Only you and the Mario Bros. can rescue Princess Toadstool from the clutches of the evil Bowser. </p>
    <p>For more than 25 years, the Super Mario series has conquered the charts and won the hearts of fans the world over. Now you can discover - or rediscover - the original game that made Mario a household name.</p>
    <p>Run and jump with Mario or Luigi through caves and castles, down pipes and across platforms, and face off against Bowser to rescue your beloved Princess Peach.</p>
    <p>It may be more than a quarter of a century old, but Super Mario Bros. is still as enchanting as ever!</p>
    Release Date:
    1985-09-13
    Metacrtic Rating:
    0 out of 100
    Player Ratings:
            Recommended: 50.25%
            Exceptional: 41.13%
            Mediocre: 5.67%
            No Interest: 2.96%
    Would you like to go back to the game list, start a new search, or exit?
    Type "list", "new", or "exit"'

Type "list" to go back to the list of results, "new" to look for other games, or "exit" to exit the application. 

# Short Explanation of How this Application Works

This application uses the REST Client to pull information from an api database. The application uses two get requests to get information. The first get retrieves the titles that are similar to what the user typed. The second get request retrieves the detailed information of the specific game that the user want more information about.