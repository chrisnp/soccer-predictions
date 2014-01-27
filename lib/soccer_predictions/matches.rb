module SoccerPredictions
  module Collection
    Match = environment[:matches].extend(Module.new do
      def before(date = Date.today)
        restrict { |m| m.date.lt(date) }
      end
    end)
  end
end
