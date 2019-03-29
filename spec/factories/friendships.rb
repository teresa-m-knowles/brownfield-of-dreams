# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user
    friend_id { 1 }
  end
end
