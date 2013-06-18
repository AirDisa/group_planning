class ChargesController < ApplicationController

  def new
  end

  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    token = params[:stripeToken]
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => token
    )

    invitee = Invitee.find_by_event_id_and_user_id(params[:event_id], current_user.id)
    invitee.update_attributes(stripe_id: customer.id,
                              responded: true,
                              status: params[:status])

    flash[:success] = "Your card information has been saved."
    redirect_to :back
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end

end
