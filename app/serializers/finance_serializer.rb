class FinanceSerializer < ActiveModel::Serializer
  attributes :gross_income, :expenses, :tax_amount, :net_profit

  has_many :orders do
    object.orders.where(status: Order::statuses[:done])
  end
end
