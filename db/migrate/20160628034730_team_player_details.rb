class TeamPlayerDetails < ActiveRecord::Migration
  def change
    create_table :team_player_details do |t|
      t.boolean  :key_position, null: false
      t.integer  :skill_level, null: false
      t.integer  :player_id, null: false
      t.integer  :team_id

      t.timestamps null: false
    end
  end
end
