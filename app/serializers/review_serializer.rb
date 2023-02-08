class ReviewSerializer < ActiveModel::Serializer
  attributes :titles, :description, :score, :product_id

  belongs_to :product, serializer: ProductSerializer
end
