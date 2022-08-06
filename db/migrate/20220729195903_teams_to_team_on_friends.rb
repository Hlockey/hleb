# frozen_string_literal: true

class TeamsToTeamOnFriends < ActiveRecord::Migration[7.0]
  def change
    remove_column(:friends, :teams)
    add_column(:friends, :team, :integer, null: false)
  end
end
