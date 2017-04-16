class AddCommentsToRecipe < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.boolean :by_admin
      t.belongs_to :user, index: true
      t.belongs_to :recipe, index: true

      t.timestamps
    end
  end
end
