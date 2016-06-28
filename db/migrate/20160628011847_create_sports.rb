class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.integer :name, null: false

      t.timestamps null: false
    end
  end
end
