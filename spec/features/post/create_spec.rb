require 'rails_helper'

feature 'User can create post', '
  In order to share with community
  As an authenticated user
  User would like to be able to publish the post
' do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit posts_path
      click_on 'New post'
    end

    scenario 'Publish a post' do
      fill_in 'Title', with: 'Test post'
      fill_in 'Description', with: 'Test description'
      fill_in 'Body', with: 'text text text'

      click_on 'Publish post'

      expect(page).to have_content 'Your post successfully created'
      expect(page).to have_content 'Test post'
      expect(page).to have_content 'Test description'
    end

    scenario 'Publish a post with errors' do
      click_on 'Publish post'
      expect(page).to have_content "too short"
    end

    scenario 'Publish a post with attached file' do
      fill_in 'Title', with: 'Test post'
      fill_in 'Description', with: 'Test description'
      fill_in 'Body', with: 'text text text'
      attach_file 'Image', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Publish post'

      visit post_path(Post.last)
      click_on 'Edit'
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Tries to publish a post' do
      visit posts_path
      click_on 'New post'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
