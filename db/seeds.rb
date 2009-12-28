require 'faker'
require 'populator'

User.destroy_all

100.times do
  user = User.new
  user.login = Faker::Internet.user_name
  user.name = Faker::Internet.user_name
  user.email = Faker::Internet.email
  user.password = "test"
  user.password_confirmation = "test"
  user.location = Faker::Address.zip_code
  user.latitude = rand * (47 - 23) + 23
  user.longitude = rand * ((-68) - (-123)) + (-123)
  user.biography = Faker::Lorem.sentences
  user.save
end

User.all.each do |user|
    Post.populate(5..10) do |post|
      post.title = Faker::Lorem.sentence
      post.message = Faker::Lorem.sentence
      post.latitude = rand * (47 - 23) + 23
      post.longitude = rand * ((-68) - (-123)) + (-123)
      #post.location = Faker::Address.city
      post.user_id = user.id
    end
end