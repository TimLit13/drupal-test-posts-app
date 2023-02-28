require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user_post) { create(:post, :with_images, user: user) }
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }

  describe 'DELETE #destroy' do
    context 'Authenticated user' do
      context 'author of post' do
        before { login(user) }

        it 'can delete attachment' do
          delete :destroy, params: { id: user_post.images.records.first, format: :js }
          user_post.reload

          expect(user_post.images.records.length).to eq(1)
        end

        it 'not redirects' do
          delete :destroy, params: { id: user_post.images.records.first, format: :js }

          expect(response).to_not have_http_status(:redirect)
        end
      end

      context 'not author of post' do
        before { login(second_user) }

        it 'can not delete attachment' do
          delete :destroy, params: { id: user_post.images.records.first, format: :js }
          user_post.reload

          expect(user_post.images.records.length).to eq(2)
        end
      end
    end

    context 'Unauthenticated user' do
      it 'can not delete attachment' do
        delete :destroy, params: { id: user_post.images.records.first, format: :js }
        user_post.reload

        expect(user_post.images.records.length).to eq(2)
      end
    end
  end
end
