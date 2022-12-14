# frozen_string_literal: true

class CreateActiveSessions < ActiveRecord::Migration[7.0]
  def change
    create_table(:active_sessions) do |t|
      t.references(:friend, null: false, foreign_key: { on_delete: :cascade })
      t.timestamps
    end
  end
end
