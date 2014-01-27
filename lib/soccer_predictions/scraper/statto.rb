require 'nokogiri'
require 'open-uri'

module SoccerPredictions
  module Scraper
    class Statto
      def initialize(team, season)
        @url = "http://www.statto.com/football/teams/#{team}/#{season}/results"
      end

      def fetch
        doc.css('#content .teamRes table').first.css('tr')[2..-1].map do |tr|
          tds = tr.css('td').map(&:content)
          { date: parse_date(tds[1]), opponent: tds[2], venue: tds[3],
            result: parse_result(tr), position: tds[5].to_i, points: tds[6].to_i }
        end
      end

      private

      def parse_date(text)
        Date.parse(text)
      end

      def parse_result(tr)
        { rnl: 'loss', rnd: 'draw', rnw: 'win' }[tr['class'].to_sym]
      end

      def doc
        @doc ||= Nokogiri::HTML(open(@url))
      end
    end
  end
end
