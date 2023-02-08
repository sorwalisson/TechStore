class Stock < ApplicationRecord
  belongs_to :product

  def add_batch(amount_product)
    self.stock_amount += amount_product
    self.save
  end

  def subtract_item(item_amount)
    self.stock_amount -= item_amount
    self.save
  end

  def add_sold_amount(sold_amount)
    self.sold_amount += sold_amount
    self.save
  end
end
