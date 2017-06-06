class AddDiscussions < ActiveRecord::Migration[5.0]
  def change
    create_table :discussions do |t|
      t.string :body
      t.belongs_to :user, index: true
      t.belongs_to :comment, index: true

      t.timestamps
    end
  end
end
