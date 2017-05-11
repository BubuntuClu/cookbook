class AddImageToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :preview_image, :string
  end
end
