FactoryBot.define do
  factory :article do
    title { Faker::Alphanumeric.alphanumeric(number: 10) }
    content { Faker::Alphanumeric.alphanumeric(number: 100) }
    user_id { FactoryBot.create(:user).id }
  end
end
