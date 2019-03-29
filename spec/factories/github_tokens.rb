# frozen_string_literal: true

FactoryBot.define do
  factory :github_token do
    user
    token { null }
  end
end
