module SoccerPredictions
  def self.environment
    ROM::Environment.setup(yaml: 'yaml://db/soccer_predictions.yml')
  end
end

require "soccer_predictions/schema"

require "soccer_predictions/version"
require "soccer_predictions/scraper/statto"
require "soccer_predictions/match"
require "soccer_predictions/neural_network"
require "soccer_predictions/prediction"
require "soccer_predictions/team"

require "soccer_predictions/mapping"
