require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user_post) { create(:post, user: user) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:posts) { create_list(:post, 3, user: user) }

    before { get :index }

    it 'fill an array of all posts' do
      expect(assigns(:posts)).to match_array(posts)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: user_post } }

    it 'assigns requested post to @post' do
      expect(assigns(:post)).to eq(user_post)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      login(user)
      get :new
    end

    it 'assigns a new post to @post' do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      login(user)
      get :edit, params: { id: user_post }
    end

    it 'assigns requested post to @post' do
      expect(assigns(:post)).to eq(user_post)
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new post in db' do
        expect { post :create, params: { post: attributes_for(:post) } }.to change(Post, :count).by(1)
      end

      it 'redirects to index view' do
        post :create, params: { post: attributes_for(:post) }

        expect(response).to redirect_to posts_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the post' do
        expect do
          post :create, params: { post: attributes_for(:post, :invalid) }
        end.not_to change(Post, :count)
      end

      it 're-renders new view' do
        post :create, params: { post: attributes_for(:post, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user_post) { create(:post, user: user) }

    context 'Authenticated user' do
      before { login(user) }

      context 'With valid attributes' do
        it 'changes post attributes' do
          patch :update, params: { id: user_post, post: { body: 'Edited post' } }
          user_post.reload
          expect(user_post.body).to eq('Edited post')
        end

        it 'renders update view' do
          patch :update, params: { id: user_post, post: { body: 'Edited post' } }
          expect(response).to redirect_to posts_path
        end
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'does not update the post' do
        expect do
          patch :update, params: { id: user_post, post: attributes_for(:post, :invalid) }
        end.not_to change(Post, :count)
      end

      it 're-renders edit view' do
        patch :update, params: { id: user_post, post: attributes_for(:post, :invalid) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:user_post) { create(:post, user: user) }

    it 'deletes post' do
      expect { delete :destroy, params: { id: user_post } }.to change(Post, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: user_post }
      expect(response).to redirect_to posts_path
    end
  end
end
