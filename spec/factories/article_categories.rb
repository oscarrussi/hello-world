FactoryBot.define do
  factory :article_category do
    article_id { FactoryBot.create(:article).id }
    category_id { FactoryBot.create(:category).id }
  end
end
