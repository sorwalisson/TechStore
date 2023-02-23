class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, as: :sellable
  has_many :products, through: :items

  
  def calculate_total
    result = 0
    self.items.each do |piece|
      @product = Product.find_by(id: piece.product_id)
      result += @product.price*piece.amount
    end
    self.total = result
    self.save!
  end

  def add_item(id_product, add_amount)
    if self.items.find_by(product_id: id_product).nil?
      Item.create(product_id: id_product, amount: add_amount, sellable_type: "Cart", sellable_id: self.id) #this part if the user doesnt have the item in the cart
    else
      new_amount = self.items.find_by(product_id: id_product).amount + add_amount
      self.items.find_by(product_id: id_product).update(amount: new_amount) #this one if he has.
    end
    calculate_total()
  end

  def exclude_item(id_item)
    self.items.find_by(id: id_item).destroy()
    calculate_total()
  end

  def create_order(userid, financeid) #change the polymorphic type and id from Cart to Order
    if self.items.count > 0
      @finance = Finance.first()
      @order = Order.create(user_id: self.user_id, finance_id: @finance.id)
      self.items.each do |changer|
        changer.update(sellable_type: "Order", sellable_id: @order.id)
        Stock.find_by(product_id: changer.product_id).subtract_item(changer.amount) #subtract item from stock
        Product.find_by(id: changer.product_id).check_availability #update if the items is still available for sale
      end
    end
  end

  def clean_cart
    self.items.each do |item|
      item.destroy
    end
    calculate_total()
  end

end
