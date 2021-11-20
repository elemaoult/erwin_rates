class DonationsController < ApplicationController
  # skip_after_action :verify_authorized

  def new
    @donation = Donation.new
  end

  def index
    @donations = Donation.all
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def create
    donation = Donation.create!(amount: params[:donation][:amount], state: 'en attente')

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: "donation-#{donation.id}",
        amount: donation.amount_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: donation_url(donation),
      cancel_url: donation_url(donation)
    )

    donation.update(checkout_session_id: session.id)
    redirect_to new_donation_payment_path(donation)
  end
end
