require 'rails_helper'

feature 'User can create comment to post', '
  In order to communicate in real time
  User should be able to create comment and
  Other users should be able to see it in real time
' do
  given(:first_user) { create(:user) }
  given(:first_user_post) { create(:post, user: first_user) }

  describe 'Authenticated user' do
    background do
      sign_in(first_user)
      visit post_path(first_user_post)
    end

    scenario 'Can see form for create comment to post' do
      within '.new-comment' do
        expect(page).to have_selector(:link_or_button, 'Send comment')
      end
    end
  end

  describe 'Unauthenticated user' do
    background { visit post_path(first_user_post) }

    scenario 'Can not create a comment' do
      expect(page).not_to have_selector(:link_or_button, 'Send comment')
    end
  end
end
