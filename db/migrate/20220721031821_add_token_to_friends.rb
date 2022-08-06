# frozen_string_literal: true

class AddTokenToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column(:friends, :token, :string, null: false)
    add_index(:friends, :token, unique: true)
  end
end
