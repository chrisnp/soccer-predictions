module SoccerPredictions
  class Betting
    include Virtus.model
    
    attribute :match, Match
    attribute :win_odds, Float
    attribute :draw_odds, Float
    attribute :lose_odds, Float

    def to_a
      [win_odds, lose_odds, draw_odds]
    end
  end
end
