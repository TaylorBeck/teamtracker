class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.time :time
      t.string :location
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
