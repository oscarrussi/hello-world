FactoryBot.define do
  factory :category do
    name { Faker::Alphanumeric.unique.alphanumeric(number: 30) }
    cod { Faker::Alphanumeric.unique.alphanumeric(number: 30) }
  end
end
