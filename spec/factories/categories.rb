FactoryBot.define do
  factory :category do
    name { Faker::Hobby.unique.activity }
    cod {Faker::Alphanumeric.unique.alphanumeric(number: 3)}
  end
end
