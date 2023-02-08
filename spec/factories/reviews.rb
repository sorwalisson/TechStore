FactoryBot.define do
  factory :review do
    title { "MyString" }
    description { "MyText" }
    score { 1 }
    product { nil }
  end
end
