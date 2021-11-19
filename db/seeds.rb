# create users
5.times do
  pass_length = Faker::Number.between(from: 6, to: 20)
  pass = Faker::Alphanumeric.alphanumeric(number: pass_length)
  birthday = Faker::Date.between(from: '1000-01-01', to: '2021-09-23')
  User.create(name: Faker::Name.name, email: Faker::Internet.unique.email, 
              birthday: birthday,
              password: pass, password_confirmation: pass)
end
# create categories
50.times{Category.create(name: Faker::Hobby.unique.activity, cod: Faker::Alphanumeric.unique.alphanumeric(number: 3))}
# create articles
User.all.each do |user| 
  (5..10).to_a.sample.times do
    user.articles.create(title: Faker::Alphanumeric.alphanumeric(number: 10),
    content: Faker::Alphanumeric.alphanumeric(number: 100))
  end
end
Article.all.each do |article|
  # create comments
  (5..10).to_a.sample.times{article.comments.create(message: Faker::Alphanumeric.alphanumeric(number: 10), user_id: User.all.sample.id)}
  # create article-categories
  random_number = (5..10).to_a.sample
  Category.all.sample(random_number).each{|category| article.article_categories.create(category_id: category.id)}
end



