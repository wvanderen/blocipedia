class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  
  
  def new
    @stripe_btn_data = {
      key: "#{ ENV['STRIPE_PUBLISHABLE_KEY'] }",
      description: "Premium Membership - #{current_user.email}",
      amount: @amount
    }
  end
 
 def create
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: @amount,
     description: "Premium Membership - #{current_user.email}",
     currency: 'usd'
   )
 
   flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
   redirect_to upgrade_users_path
 
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
  
     redirect_to new_charge_path
 end
 
 private
 
 def amount_to_be_charged
   @amount = 1500
 end
 
end