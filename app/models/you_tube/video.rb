# frozen_string_literal: true

module YouTube
  # Video PORO
  class Video
    attr_reader :thumbnail

    def initialize(data = {})
      if data[:items].any?
        @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
      end
    end

    def self.by_id(id)
      new(YoutubeService.new.video_info(id))
    end
  end
end
