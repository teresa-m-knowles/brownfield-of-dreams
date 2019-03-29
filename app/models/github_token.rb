# frozen_string_literal: true

# Github Token model. Belongs to user
class GithubToken < ApplicationRecord
  belongs_to :user
  validates_presence_of :token
end
