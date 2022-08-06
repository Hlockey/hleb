# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table(:votes) do |t|
      t.string(:category, null: false)
      t.string(:name, null: false)
      t.integer(:team, null: false)

      t.timestamps
    end
  end
end
