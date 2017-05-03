class CreateVoteTAble < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :votable_type
      t.belongs_to :user, index: true
      t.integer :value
      
      t.timestamp
    end
    add_index :votes, [:votable_id, :votable_type]
  end
end
