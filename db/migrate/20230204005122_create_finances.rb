class CreateFinances < ActiveRecord::Migration[7.0]
  def change
    create_table :finances do |t|
      t.float :gross_income
      t.float :expenses
      t.float :net_profit
      t.float :tax_amount

      t.timestamps
    end
  end
end
