class Game
    attr_reader :name, :slug, :description, :released, :metacritic_rating, :exceptional_rating, :recommended_rating, :meh_rating, :skip_rating
    @@all = []

    def initialize(name, slug, description = nil, released = nil, metacritic_rating = nil, exceptional_rating = nil, recommended_rating = nil, meh_rating = nil, skip_rating = nil)
        @name = name
        @slug = slug
        @description = description
        @released = released
        @metacritic_rating = metacritic_rating
        @exceptional_rating = exceptional_rating
        @recommended_rating = recommended_rating
        @meh_rating = meh_rating
        @skip_rating = skip_rating
        
        @@all << self
    end

    def self.all
        @@all
    end
end