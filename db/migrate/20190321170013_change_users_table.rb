# frozen_string_literal: true

class ChangeUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
  end
end
