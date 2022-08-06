# frozen_string_literal: true

class AddPasswordColumnToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column(:friends, :password_digest, :string, null: false)
  end
end
