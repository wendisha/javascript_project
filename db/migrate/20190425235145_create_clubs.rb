class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :city
      t.string :nation
      t.string :league_division
      t.integer :user_id
    end
  end
end
