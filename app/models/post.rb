class Post < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  validates :title, uniqueness: true
  validates :title, :description, :body, length: { minimum: 3 }, allow_nil: false
end
