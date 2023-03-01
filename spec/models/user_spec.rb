require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should have_db_index(:email).unique(true) }
    it { should validate_presence_of :password }
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
