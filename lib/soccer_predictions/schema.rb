SoccerPredictions.environment.schema do
  base_relation :matches do
    repository :yaml

    attribute :id, Integer
    attribute :home_team_id, Integer
    attribute :away_team_id, Integer
    attribute :result, String
    attribute :date, Date

    key :id
  end

  base_relation :teams do
    repository :yaml

    attribute :id, Integer
    attribute :name, String

    key :id
  end
end
