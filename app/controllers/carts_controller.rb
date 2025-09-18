class CartsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :checkout, :show ]
  before_action :set_cart, only: [:show, :checkout, :success, :cancel]

  def show
    @cart_items = @cart.cart_items.includes(:hair)
  end

  Stripe.api_key = ENV['STRIPE_SECRET_KEY'] # ensure this pulls from environment variables
  def checkout
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: @cart.cart_items.map do |item|
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: item.hair.name,
            },
            unit_amount: (item.hair.price * 100).to_i,
          },
          quantity: item.quantity,
        }
      end,
      mode: 'payment',
      success_url: success_cart_url,
      cancel_url: cancel_cart_url
    )

    redirect_to session.url, allow_other_host: true
  end


  def success
    # Mark the cart as paid
    @cart.update(order_status: "paid")
    redirect_to cart_path, notice: "Payment successful! Thank you for your order."
  end

  def cancel
    redirect_to cart_path, alert: "Payment cancelled. Please try again."
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart!(order_status: "pending", total: 0.0)
  end
end
