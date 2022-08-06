# frozen_string_literal: true

class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table(:friends) do |t|
      t.string(:username, null: false)
      t.timestamps
    end

    add_index(:friends, :username, unique: true)
  end
end
