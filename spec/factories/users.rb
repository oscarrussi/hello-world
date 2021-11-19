FactoryBot.define do
  pass_length = Faker::Number.between(from: 6, to: 20)
  pass = Faker::Alphanumeric.alphanumeric(number: pass_length)
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    birthday {Faker::Date.between(from: '1000-01-01', to: '2021-09-23')}
    password { pass }
    password_confirmation { pass }
  end
end
