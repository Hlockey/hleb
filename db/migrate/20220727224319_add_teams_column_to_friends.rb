# frozen_string_literal: true

class AddTeamsColumnToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column(:friends, :teams, :integer, array: true, null: false)
  end
end
