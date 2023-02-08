class OrderSerializer < ActiveModel::Serializer
  attributes :status, :total_cost, :shipping_cost, :total_price, :tax_amout, :user_id, :finance_id

  belongs_to :user, serializer: UserSerializer
  belongs_to :finance, serializer: FinanceSerializer
  has_many :items, as: :sellable, serializer: ItemSerializer
  has_many :products, through: :items, serializer: ProductSerializer
end