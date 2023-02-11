class Order < ApplicationRecord
  belongs_to :user
  belongs_to :finance
  has_many :items, as: :sellable
  has_many :products, through: :items

  enum status: {open: 0, awaiting_payment: 1, paid: 2, preparing_shipment: 3, shipped: 4, arrived: 5, done: 6, cancelled: 7, returned: 8}

  def change_status(next_status)
    start_order_calculations()
    if self.status == "arrived" and next_status == "done" then Finance.find_by(id: self.finance_id).add_values_to_finance(self) end #this will call the Finance method add the value of this order to finances
    self.status = next_status
    self.save
  end
    

  def start_order_calculations # calculations procs
    calculate_total_price()
    calculate_total_tax()
    calculate_total_cost()
  end

  def calculate_total_price # will calculate the total price of the order, including shipping price.
    self.total_price = 0
    result = 0
    
    self.items.each do |piece|
      @product = Product.find_by(id: piece.product_id)
      result += @product.price*piece.amount
    end
    
    self.total_price = result + self.shipping_cost
    self.save
  end

  def calculate_total_tax
    self.tax_amout = 0
    result = 0
    
    self.items.each do |piece|
      @product = Product.find_by(id: piece.product_id)
      tax = calculate_percentage(@product.cost, @product.product_tax)
      result += tax*piece.amount
    end
    
    self.tax_amout = result
    self.save
  end

  def calculate_total_cost
    self.total_cost = 0
    result = 0
    
    self.items.each do |piece|
      @product = Product.find_by(id: piece.product_id)
      result += @product.cost*piece.amount
    end
    
    self.total_cost = result
    self.save
  end

  def calculate_percentage(value, percentage) #calculate the value of tax and send it back to the main method
    x = value*percentage / 100
    return x
  end

  def cancel_order
    if self.status == ("open" or "awainting_payment")
      self.items.each do |return_to_stock|
        Product.find_by(id: return_to_stock.product_id).stock.add_batch(return_to_stock.amount)
      end
      self.change_status("cancelled")
    end
  end
end
