class AddPriceToIngr < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :price, :float
  end
end
