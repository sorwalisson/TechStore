class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.integer :stock_amount
      t.integer :sold_amount
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
