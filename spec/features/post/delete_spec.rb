require 'rails_helper'

feature 'User can delete post' do
  given(:user) { create(:user) }
  given(:not_author_user) { create(:user) }
  given(:post_author) { create(:user) }
  given(:post) { create(:post, user: post_author) }
  given(:post_with_images) { create(:post, :with_images, user: post_author) }
  given(:first_attached_image_name) { post_with_images.files.first.filename.to_s }

  describe 'Authenticated user' do
    describe 'Author of post' do
      background do
        sign_in(post_author)
        visit post_path(post_with_images)
        click_on 'Edit post'
      end

      scenario 'can delete his post' do
        click_on 'Delete post'

        expect(page).to have_content 'Post was successfully deleted'
        expect(page).to_not have_content post.title
      end
    end

    describe 'Not author of post' do
      background do
        sign_in(not_author_user)
        visit post_path(post_with_images)
      end

      scenario 'can not delete author post' do
        expect(page).to_not have_selector(:link_or_button, 'Edit post')
        expect(page).to_not have_selector(:link_or_button, 'Delete post')
      end

      scenario 'can not delete authors attachment' do
        expect(page).to_not have_selector(:link_or_button, 'Del')
      end
    end
  end

  describe 'Unauthenticated user' do
    background do
      visit post_path(post)
    end

    scenario 'can not delete post' do
      expect(page).to_not have_selector(:link_or_button, 'Edit post')
      expect(page).to_not have_selector(:link_or_button, 'Delete post')
    end

    scenario 'can not delete attachment' do
      expect(page).to_not have_selector(:link_or_button, 'Edit post')
      expect(page).to_not have_selector(:link_or_button, 'Del')
    end
  end
end
