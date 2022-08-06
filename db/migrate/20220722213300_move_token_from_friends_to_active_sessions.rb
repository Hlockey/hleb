# frozen_string_literal: true

class MoveTokenFromFriendsToActiveSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column(:friends, :token)
    add_column(:active_sessions, :token, :string, null: false)
    add_index(:active_sessions, :token, unique: true)
  end
end
