class CreateTablesForRecipe < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :title, index: true
      t.string :description
      t.belongs_to :user, index: true

      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name
      t.string :measure
      t.belongs_to :recipe, index: true

      t.timestamps
    end

    create_table :attachments do |t|
      t.string :file
      t.string :type
      t.belongs_to :recipe, index: true
      
      t.timestamps
    end
  end
end
