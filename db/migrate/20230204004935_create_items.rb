class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :amount
      t.references :sellable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
