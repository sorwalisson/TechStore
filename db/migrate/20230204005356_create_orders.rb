class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.float :total_cost
      t.float :shipping_cost, default: 0, null: false
      t.float :total_price
      t.float :tax_amout
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :finance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
