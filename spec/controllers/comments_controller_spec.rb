require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let!(:comment_params) do
    { comment: attributes_for(:comment), post_id: user_post }
  end

  describe 'POST #create' do
    before { sign_in(user) }

    context 'with valid attributes' do
      it 'return a turbo stream' do
        post :create, params: comment_params, format: :turbo_stream
        expect(response.media_type).to eq Mime[:turbo_stream]
      end

      it 'redirect to show view' do
        post :create, params: comment_params, format: :turbo_stream

        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 're-renders new view' do
        post :create, params: comment_params.update(comment: { body: nil }), format: :turbo_stream
        expect(response).to render_template :create
      end
    end
  end
end
