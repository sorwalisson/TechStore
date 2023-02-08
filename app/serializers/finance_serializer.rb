class FinanceSerializer < ActiveModel::Serializer
  attributes :gross_income, :expenses, :tax_amount, :net_profit

  has_many :orders, serializer: OrderSerializer
end
