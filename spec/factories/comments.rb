FactoryBot.define do
  factory :comment do
    message { Faker::Alphanumeric.alphanumeric(number: 30) }
    user_id { FactoryBot.create(:user).id }
    article_id { FactoryBot.create(:article).id }
  end
end