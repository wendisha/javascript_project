class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :city
      t.string :nation
      t.string :league_division
      t.string :string
    end
  end
end
