class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create :create_cart
  
  has_many :orders
  has_one :cart

  def create_cart #every user has a cart.
    check_cart = Cart.find_by(user_id: self.id)
    if check_cart.nil?
      Cart.create(user_id: self.id)
    end
  end
end
