class OrderSerializer < ActiveModel::Serializer
  attributes :status, :total_cost, :shipping_cost, :total_price, :tax_amout, :user_id

  belongs_to :user, serializer: UserSerializer
  has_many :items, as: :sellable, serializer: ItemSerializer
end