# frozen_string_literal: true

class MakeVoteUseIntegers < ActiveRecord::Migration[7.0]
  def change
    remove_column(:votes, :category)
    remove_column(:votes, :name)
    add_column(:votes, :category, :integer, null: false)
    add_column(:votes, :option, :integer, null: false)
  end
end
