require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }
    subject { build(:post, user: user) }

    it { should have_db_index(:title).unique(true) }
    it { should validate_uniqueness_of(:title) }
    it { should validate_length_of(:title).is_at_least(3) }
    it { should validate_length_of(:description).is_at_least(3) }
    it { should validate_length_of(:body).is_at_least(3) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
