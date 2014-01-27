require 'soccer_predictions/acts_as/collection'
include SoccerPredictions

module SoccerPredictions
  class Dummy
    include ActsAs::Collection
    attr_reader :age

    collection -> { 1.upto(30).map { |age| new(age) } }
    scope :adults, -> { to_a }

    def initialize(age)
      @age = age
    end
  end
end
