class Item < ApplicationRecord
  belongs_to :sellable, polymorphic: true
  has_one :product

  def cart_item_checker # this method is to prevent items from being deleted when it belongs to an order
    if self.sellable_type == "Cart" then return true end
    if self.sellable_type == "Order" then return false end
  end
end
