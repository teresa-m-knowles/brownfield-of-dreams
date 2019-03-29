# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos

  has_one :github_token

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name

  enum role: %i[default admin]
  enum status: %i[inactive active]

  has_secure_password

  def self.github_uniq?(_user, auth)
    where(uid: auth.uid).empty?
  end

  def bookmarks
    unordered_bookmarks = videos.includes(:tutorial)
                                .order('videos.position asc')

    unordered_bookmarks.group_by(&:tutorial)
  end
end
