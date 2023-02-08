class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.integer :section
      t.boolean :available
      t.string :image_url
      t.float :cost
      t.integer :kind
      t.float :price
      t.json :general_information
      t.integer :product_tax

      t.timestamps
    end
  end
end
