require 'rails_helper'

feature 'User can edit his post', '
  In order to correct mistakes
  User would like to be able to edit his post
' do
  given(:user) { create(:user) }
  given!(:post_author) { create(:user) }
  given!(:user_post) { create(:post, user: post_author) }
  given(:another_post) { create(:post, user: user) }

  describe 'Authenticated user' do
    scenario 'Edits his post' do
      sign_in(post_author)
      visit post_path(user_post)
      click_on 'Edit post'

      fill_in 'Title', with: 'Edited post title'
      click_on 'Publish post'

      expect(page).to_not have_content user_post.title
      expect(page).to have_content 'Edited post title'
      expect(page).to_not have_selector('textarea')
    end

    scenario 'Edits his answer with errors' do
      sign_in(post_author)
      visit post_path(user_post)

      click_on 'Edit post'
      fill_in 'Body', with: nil
      click_on 'Publish post'

      expect(page).to have_content 'is too short'
      expect(page).to have_selector('textarea')
    end

    scenario 'Tries to edit other user answer' do
      sign_in(post_author)
      visit post_path(user_post)

      expect(page).to have_selector(:link_or_button, 'Edit post')
    end

    scenario 'Attach files' do
      sign_in(post_author)
      visit post_path(user_post)

      click_on 'Edit post'

      attach_file 'Images', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Publish post'

      visit post_path(user_post)
      click_on 'Edit post'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Can not edit answer' do
      visit post_path(user_post)

      expect(page).to_not have_selector(:link_or_button, 'Edit')
    end
  end
end
