class PaymentsController < ApplicationController
  def create
    token = params[:stripeToken]
    @product = Product.find(params[:product_id])
    @user = current_user

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => @product.price_in_cents, # amount in cents, again
        :currency => "cad",
        :source => token,
        :description => params[:stripeEmail]
      )

      if charge.paid
        if signed_in?
          Order.create(
            product_id: @product.id,
            user_id: @user.id,
            total: @product.price)
        else
          Order.create(
            product_id: @product.id,
            total: @product.price
          )
        end
      end

    rescue Stripe::CardError => e
      # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
      redirect_to @product_path
    end
  end
end
