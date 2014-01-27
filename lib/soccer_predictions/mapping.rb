SoccerPredictions.env.mapping do
  matches do
    header = Mapper::Header.build(
      [[:id, Integer], [:home_team_id, Integer], [:away_team_id, Integer], [:date, Date], [:result, String]],
      map: { date: :played_at }, keys: [:id, :home_team_id, :away_team_id]
    )
    mapper ROM::Mapper.build(header, Match, loader_class: SoccerPredictions::MatchLoader)
  end

  teams do
    header = Mapper::Header.build([[:id, Integer], [:name, String]], keys: [:id])
    mapper ROM::Mapper.build(header, Team, loader_class: SoccerPredictions::TeamLoader)
  end
end

module SoccerPredictions
  class MatchLoader < ROM::Mapper::Loader
    def call(tuple)
      model.new(
        home_team: home_team(tuple),
        away_team: away_team(tuple),
        played_at: tuple[:played_at],
        result: tuple[:result]
      )
    end

    private

    def result(tuple)
      Result = Class.new do
        def initiali

        def inverse
          value = case value
          when :loss then :win
          when :draw then :draw
          when :win then :loss
          end
        end
      end

      Result.new(tuple[:result])
    end

    def home_team(tuple)
      Teams.restrict(id: tuple[:home_team_id]).one
    end
    
    def away_team(tuple)
      Teams.restrict(id: tuple[:away_team_id]).one
    end
  end

  class TeamLoader < ROM::Mapper::Loader
    def call(tuple)
      model.new(name: tuple[:name], matches: matches(tuple))
    end

    private

    def matches(tuple)
      Matches.restrict { |m| m.home_team_id.eq(tuple[:id]) | m.away_team_id.eq(tuple[:id]) }
    end
  end
end
