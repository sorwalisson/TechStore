class ItemSerializer < ActiveModel::Serializer
  attributes :product_id, :amount, :sellable_type, :sellable_id
  
  belongs_to :sellable, polymorphic: true
  has_one :product, serializer: ProductSerializer
end