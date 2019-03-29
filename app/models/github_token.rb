# frozen_string_literal: true

# GithubToken model. Belongs to an user.
# An User with a github token has been connected to Github.
class GithubToken < ApplicationRecord
  belongs_to :user
  validates_presence_of :token
end
