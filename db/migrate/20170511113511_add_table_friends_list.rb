class AddTableFriendsList < ActiveRecord::Migration[5.0]
  def change
    create_table :friends_lists do |t|
      t.integer :friends, array: true, default: []
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
