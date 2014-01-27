require 'ai4r'

module SoccerPredictions
  class NeuralNetwork < Ai4r::NeuralNetwork::Backpropagation
    # Home team, away team, rank, past match results, odds
    INPUTS = 20 + 20 + 5 + 1 + 3

    # Proportional to number of inputs
    HIDDEN_LAYERS = (INPUTS / 2.0).floor
    
    # Loss, draw and win probablilites
    OUTPUTS = 3

    def initialize
      super(INPUTS, HIDDEN_LAYERS, OUTPUTS)
    end

    def eval(match)
      super(build_inputs(match))
    end

    def eval_result(match)
      super(build_inputs(match))
    end

    def train(match)
      super(build_inputs(match), build_outputs(match))
    end

    private

    def build_inputs(match)
      [:teams, :rank, :form, :odds].map { |input_type|
        case input_type
        when :teams
          normalize_playing_team(match.home_team) + normalize_playing_team(match.away_team)
        when :rank, :form
          [match.home_team, match.away_team].map do |team|
            send("normalize_team_#{input_type}", team.send(input_type, match.date))
          end
        when :odds
          normalize_match_odds(match.odds)
        end
      }.flatten
    end

    def build_outputs(match)
      %w(loss draw win).map { |result| result == match.result }
    end

    def normalize_playing_team(team)
      Team.all.map { |t| t == team ? 1 : 0 }
    end

    def normalize_team_rank(rank)
      (rank / Team.count.to_f)
    end

    def normalize_team_form(form)
      form.map { |result| [0, 0.5, 1][%(lost drawn won).index(result)] }
    end

    def normalize_match_odds(odds)
      sum = odds.to_a.reduce(&:+)
      odds.map { |number| number / sum.to_f }
    end
  end
end
