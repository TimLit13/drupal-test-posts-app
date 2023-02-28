require 'rails_helper'

feature 'User can see pagination' do
  given(:post_author) { create(:user) }
  given(:post_list) { create_list(:post, 100, user: post_author) }

  describe 'Authenticated user' do
    background do
      sign_in(post_author)
      visit posts_path
    end

    scenario 'can see pagination on page' do
      expect(page).to have_selector(:link_or_button, 'Prev')
      expect(page).to have_selector(:link_or_button, '1')
      expect(page).to have_selector(:link_or_button, 'Next')
      expect(page).to have_selector(:link_or_button, 'Show by')
    end
  end

  describe 'Unauthenticated user' do
    background do
      visit posts_path
    end

    scenario 'can see pagination on page' do
      expect(page).to have_selector(:link_or_button, 'Prev')
      expect(page).to have_selector(:link_or_button, '1')
      expect(page).to have_selector(:link_or_button, 'Next')
      expect(page).to have_selector(:link_or_button, 'Show by')
    end
  end
end
