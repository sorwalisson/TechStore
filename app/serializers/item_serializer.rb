class ItemSerializer < ActiveModel::Serializer
  attributes :product_id, :amount, :sellable_type, :sellable_id
  
  belongs_to :sellable, polymorphic: true
end