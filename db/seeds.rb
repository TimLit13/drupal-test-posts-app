require 'faker'

USERS_SEED = 5
POSTS_PER_USER = 20
COMMENTS_PER_POST = 5

# seed users
users = []
1.upto(USERS_SEED) do
  user_email = Faker::Internet.unique.email
  password = '111111'
  password_confirmation = '111111'
  confirmed_at = DateTime.now
  users.push User.create(
    email: user_email,
    password: password,
    password_confirmation: password_confirmation,
    confirmed_at: confirmed_at
  )
end

# seed posts
posts = []
users.each do |user|
  1.upto(POSTS_PER_USER) do
    title = Faker::Fantasy::Tolkien.unique.character
    description = Faker::Lorem.unique.paragraph(sentence_count: 1)
    body = Faker::Lorem.unique.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 10)
    posts.push Post.create(title: title, description: description, body: body, user: user)
  end
end

# seed comments
posts.each do |post|
  1.upto(COMMENTS_PER_POST) do
    body = Faker::Lorem.unique.paragraph(sentence_count: 1)
    Comment.create(body: body, user: users.sample, post: post)
  end
end
