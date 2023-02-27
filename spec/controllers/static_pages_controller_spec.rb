require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #about' do
    let(:user) { create(:user) }

    before { login(user) }

    it 'returns http success' do
      get :about
      expect(response).to have_http_status(:success)
    end
  end
end
