FactoryBot.define do
  factory :stock do
    stock_amount { 1 }
    sold_amount { 1 }
    product { nil }
  end
end
