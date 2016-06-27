class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string   :name, null: false
      t.string   :sport, null: false
      t.integer  :min_players, null: false
      t.integer  :ideal_players, null: false
      t.integer  :min_females, null: false
      t.integer  :manager_id

      t.timestamps null: false
    end
  end
end
