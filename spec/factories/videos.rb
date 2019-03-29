# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title { Faker::Games::Pokemon.name }
    description { Faker::TvShows::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    tutorial
    thumbnail {"https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg"}
  end
end
