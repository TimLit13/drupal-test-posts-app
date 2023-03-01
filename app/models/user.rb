class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def author_of?(resource)
    resource.user_id == self.id
  end
end
