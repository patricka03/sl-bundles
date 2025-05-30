class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :destroy]

  def create
    # Ensure the current user has a cart; if not, create one.
    @cart = current_user.cart || current_user.create_cart!(order_status: "pending", total: 0.0)
    hair = Hair.find(params[:hair_id])
    # Check for an existing cart item for this hair; if exists increment quantity.
    @cart_item = @cart.cart_items.find_by(hair_id: hair.id)
    if @cart_item
      @cart_item.increment!(:quantity)
    else
      @cart_item = @cart.cart_items.create!(hair: hair, quantity: 1)
    end
    update_cart_total(@cart)
    redirect_to cart_path, notice: "#{hair.name} added to cart!"
  end

  def update
    if @cart_item.update(cart_item_params)
      update_cart_total(@cart_item.cart)
      redirect_to cart_path, notice: "Cart item updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    cart = @cart_item.cart
    @cart_item.destroy
    update_cart_total(cart)
    redirect_to cart_path, notice: "Item removed from cart."
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  def update_cart_total(cart)
  # Use includes to avoid N+1 queries.
  total_price = cart.cart_items.includes(:hair).inject(0) do |sum, item|
    # Ensure hair.price is interpreted as a number (float/decimal)
    sum + (item.hair.price.to_f * item.quantity)
  end
  cart.update(total: total_price)
  end
end
