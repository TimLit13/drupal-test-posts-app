require 'faker'

USERS_SEED = 5
POSTS_PER_USER = 20

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
users.each do |user|
  1.upto(POSTS_PER_USER) do
    title = Faker::Fantasy::Tolkien.unique.character
    description = Faker::Lorem.unique.paragraph(sentence_count: 1)
    body = Faker::Lorem.unique.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 10)
    Post.create(title: title, description: description, body: body, user: user)
  end
end
