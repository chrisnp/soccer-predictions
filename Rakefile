require 'yaml'
require 'soccer_predictions'
require 'bundler/gem_tasks'

namespace :db do
  task :import do
    %w(arsenal chelsea manchester-united).each do |team|
      %w(2010-2011 2011-2012 2012-2013 2013-2014).each do |season|
        File.open("./db/english-premier-league-#{team}-#{season}.yml", 'w') do |file|
          file.write(SoccerPredictions::Scraper::Statto.new(team, season).fetch.to_yaml)
        end
      end
    end
  end
end
