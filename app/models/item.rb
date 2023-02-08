class Item < ApplicationRecord
  belongs_to :sellable, polymorphic: true
  has_one :product
end
