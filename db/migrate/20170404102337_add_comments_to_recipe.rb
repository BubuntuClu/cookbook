class AddCommentsToRecipe < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.belongs_to :recipe, index: true

      t.timestamps
    end
  end
end
