# frozen_string_literal: true

# Video Model
class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :video_id
  validates_presence_of :position
  validates_presence_of :thumbnail
end
