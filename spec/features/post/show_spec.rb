require 'rails_helper'

feature 'User can see posts and answers' do
  given(:user) { create(:user) }
  given(:user_post) { create(:post, user: user) }

  scenario 'Can see post' do
    visit post_path(user_post)
    expect(page).to have_content('MyString', count: 1)
  end
end
