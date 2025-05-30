class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :hairs, through: :cart_items
  validates :total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recalculate_total!
    new_total = cart_items.includes(:hair).sum do |item|
      item.hair.price.to_f * item.quantity
    end
    update(total: new_total)
  end
end
