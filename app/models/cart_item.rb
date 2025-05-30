class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :hair
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  private
  
  def update_cart_total
    cart.recalculate_total!
  end
end
