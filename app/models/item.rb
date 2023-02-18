class Item < ApplicationRecord
  belongs_to :sellable, polymorphic: true
  has_one :product

  def cart_item_checker(id) # this method is to prevent items from being deleted when it belongs to an order
    verifier = Item.find_by(id: id)
    if verifier.sellable_type?("Cart") then return true end
    if verifier.sellable_type?("Order") then return false end
  end
end
