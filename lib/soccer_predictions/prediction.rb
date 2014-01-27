require 'ai4r'

module SoccerPredictions
  class Prediction
    def initialize(past_matches)
      @neural_network = NeuralNetwork.new
      train_neural_network(past_matches)
    end

    def make(match)
      Hash[%i(loss draw win).zip(@neural_network.eval(match))]
    end

    private

    def train_neural_network(past_matches)
      2000.times { past_matches.each { |match| @neural_network.train(match) } }
    end
  end
end
