class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :length
      t.integer :weekly_salary
      t.integer :transfer_fee
      t.text :unusual_clauses
      t.string :status
      t.integer :futbolista_id
      t.integer :club_id
      t.integer :agent_id
    end
  end
end
