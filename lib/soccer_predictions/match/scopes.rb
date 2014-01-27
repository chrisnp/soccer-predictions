module SoccerPredictions
  class Match
    module Scopes
      def before(date)
        replace(select { |match| match.date < date })
      end

      def played_by(team)
        replace(select { |match| [match.home_team, match.away_team].include?(team) })
      end

      def limit(n)
        replace(take(n))
      end
    end
  end
end
