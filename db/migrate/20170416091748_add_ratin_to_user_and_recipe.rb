class AddRatinToUserAndRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rating, :float, default: 0
    add_column :recipes, :rating, :integer, default: 0
  end
end
