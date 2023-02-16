class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :title, :description, :score, presence: true
end