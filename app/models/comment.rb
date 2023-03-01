class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true

  scope :sorted, -> { order(created_at: :asc) }
end
