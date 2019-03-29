# frozen_string_literal: true

# Friendship model. It's one way, between two users.
# Both users should have uids that are not nil
# These uids are their github ids
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validate :friend_themselves_check

  private

  def friend_themselves_check
    errors.add(:friendship, 'You cannot add yourself as a friend.') if same_user
  end

  def same_user
    user && friend && user.uid == friend.uid
  end
end
