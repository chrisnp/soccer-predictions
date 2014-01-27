module SoccerPredictions
  class Match
    include Virtus.model
    
    attribute :played_at, Date
    attribute :home_team, Team
    attribute :away_team, Team
    attribute :odds, Betting
    attribute :result, Symbol

    def result_for(team)
      case team
      when home_team then result
      when away_team then inverted_result
      end
    end

    # TODO: Improve this
    def predict(past_matches = Matches.before(played_at))
      Prediction.new(past_matches).make(self)
    end

    private

    def inverted_result
      case result
      when :loss then :win
      when :draw then :draw
      when :win then :loss
      end
    end
  end
end