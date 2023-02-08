FactoryBot.define do
  factory :product do
    name { "RTX 4070" }
    brand { "Gigabyte" }
    section { 0 }
    available { true }
    image_url { "MyString" }
    cost { 2000 }
    kind { 1 }
    price { 4000 }
    general_information { "justesting" }
    product_tax { 30 }
  end
end
