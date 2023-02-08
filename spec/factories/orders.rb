FactoryBot.define do
  factory :order do
    status { 1 }
    total_cost { 1.5 }
    shipping_cost { 1.5 }
    total_price { 1.5 }
    tax_amout { 1.5 }
    user { nil }
    finance { nil }
  end
end
