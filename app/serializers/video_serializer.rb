# frozen_string_literal: true

# Serializer for the Video model
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :position
end
