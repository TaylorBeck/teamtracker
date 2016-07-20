class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :responder_id, null: false
      t.integer :game_id, null: false
      t.string :response, null: false, default: "none"

      t.timestamps(null: false)
    end
  end
end
