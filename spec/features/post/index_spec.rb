require 'rails_helper'

feature 'Anybody can view list of posts' do
  given(:user) { create(:user) }
  given!(:list_of_posts) { create_list(:post, 3, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'Can view posts' do
      visit posts_path
      expect(page).to have_content('MyString', count: 3)
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Can view posts' do
      visit posts_path
      expect(page).to have_content('MyString', count: 3)
    end
  end
end
