# frozen_string_literal: true

class AddVotesColumnToFriend < ActiveRecord::Migration[7.0]
  def change
    add_column(:friends, :votes, :integer, default: 3, null: false)
  end
end
