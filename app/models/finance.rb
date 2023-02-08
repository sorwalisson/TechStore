class Finance < ApplicationRecord
  has_many :orders

  #this method is used to restart all calculations, calculations that preserve the pre-existing value will be described down below
  def start_calculations
    self.tax_amount = 0
    self.expenses = 0
    self.gross_income = 0
    self.net_profit = 0
    self.orders.where(status: "done").each do |piece|
      calculate_tax_amount(piece.tax_amout)
      calculate_expenses(piece.total_cost, piece.shipping_cost)
      calculate_gross_income(piece.total_price)
    end
    calculate_net_profit(self.gross_income, self.tax_amount, self.expenses)
  end

  #sum with new order
  def add_values_to_finance(new_order)
    calculate_tax_amount(new_order.tax_amout)
    calculate_expenses(new_order.total_cost, new_order.shipping_cost)
    calculate_gross_income(new_order.total_price)
    calculate_net_profit(self.gross_income, self.tax_amount, self.expenses)
  end
    
  # sum
  def calculate_tax_amount(value_tax)
    self.tax_amount += value_tax
    self.save
  end

  def calculate_expenses(value_cost, value_shipment)
    self.expenses += value_cost + value_shipment
    self.save
  end

  def calculate_gross_income(value_income)
    self.gross_income += value_income
    self.save
  end
  # calculate net profit
  def calculate_net_profit(value_gross_income, value_tax_amount, value_expenses)
    subtractor = value_expenses + value_tax_amount
    self.net_profit = value_gross_income - subtractor
    self.save
  end


end
