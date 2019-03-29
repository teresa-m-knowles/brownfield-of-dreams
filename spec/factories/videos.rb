FactoryBot.define do
  factory :video do
    title { Faker::Pokemon.name }
    description { Faker::SiliconValley.motto }
    video_id { Faker::Crypto.md5 }
    tutorial
    thumbnail {"https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg"}
  end
end
