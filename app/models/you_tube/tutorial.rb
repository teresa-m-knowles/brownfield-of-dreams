# frozen_string_literal: true

module YouTube
  class Tutorial
    attr_reader :title
    attr_reader :description
    attr_reader :thumbnail

    def initialize(data = {})
      return @title = nil if data[:items].empty?

      @title = data[:items].first[:snippet][:title]
      @description = data[:items].first[:snippet][:description]
      @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
    end

    def self.by_id(id)
      new(YoutubeService.new.tutorial_info(id))
    end
  end
end
