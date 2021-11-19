FactoryBot.define do
  factory :role do
    name { %w[super_admin content_manager].sample }
  end
end
