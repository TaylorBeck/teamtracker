class TeamPlayerDetails < ActiveRecord::Migration
  def change
    create_table :team_player_details do |t|
      t.string  :key_position
      t.integer  :skill_level
      t.integer  :player_id
      t.integer  :team_id

      t.timestamps null: false
    end
  end
end
