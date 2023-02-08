class CartSerializer < ActiveModel::Serializer
  attributes :user_id, :total

  belongs_to :user, serializer: UserSerializer
  has_many :items, as: :sellable, serializer: ItemSerializer
  has_many :products, through: :items, serializer: ProductSerializer
end