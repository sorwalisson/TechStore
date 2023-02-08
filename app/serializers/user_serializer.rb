class UserSerializer < ActiveModel::Serializer
  attributes :name

  has_one :cart, serializer: CartSerializer
  has_many :orders, serializer: OrderSerializer
end
