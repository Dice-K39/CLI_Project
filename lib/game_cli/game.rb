class Game
    attr_accessor :name, :slug, :description, :released, :metacritic_rating, :recommended_rating, :exceptional_rating, :meh_rating, :skip_rating
    @@all = []

    def initialize(name, slug, description = nil, released = nil, metacritic_rating = 0, recommended_rating = 0.0, exceptional_rating = 0.0, meh_rating = 0.0, skip_rating = 0.0)
        @name = name
        @slug = slug
        @description = description
        @released = released
        @metacritic_rating = metacritic_rating
        @recommended_rating = recommended_rating
        @exceptional_rating = exceptional_rating        
        @meh_rating = meh_rating
        @skip_rating = skip_rating

        @@all << self
    end

    def self.all
        @@all
    end

    def self.sort_games
        @@all.each.sort {|a, b| a.name <=> b.name}
    end
end