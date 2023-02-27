class Post < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :title
  validates :title, :description, :body, length: { minimum: 3 }, allow_nil: false
end
