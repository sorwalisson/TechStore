class ProductSerializer < ActiveModel::Serializer
  attributes :name, :brand, :price, :section, :kind, :image_url, :available, :general_information, :avg_score
end