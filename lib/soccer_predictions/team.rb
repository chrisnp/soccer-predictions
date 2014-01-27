module SoccerPredictions
  class Team
    include Virtus.model

    attribute :name, String
    attribute :matches, Virtus::Attribute::Collection
    attribute :rankings, Virtus::Attribute::Collection
    
    def form(date = Date.today)
      MatchRepository.

      matches
        .before(date)
        .sort_by(:played_at).last(5)
        .map { |match| match.result_for(self) }
    end

    def rank(date = Date.today)
      rankings.restrict(date: date)
    end
  end
end
