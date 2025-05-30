class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :hairs
  has_one :cart, dependent: :destroy

  after_create :create_user_cart

  private

  def create_user_cart
    self.create_cart!(total: 0)
  end
end
