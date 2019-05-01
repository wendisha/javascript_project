class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :length
      t.string :weekly_salary
      t.string :transfer_fee
      t.text :unusual_clauses
      t.string :status
      t.integer :player_id
      t.integer :club_id
      t.integer :agent_id
      t.integer :user_id
    end
  end
end
