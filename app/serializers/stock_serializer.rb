class StockSerializer < ActiveModel::Serializer
  attributes :stock_amount, :sold_amount, :product_id

  belongs_to :product, serializer: ProductSerializer
end
