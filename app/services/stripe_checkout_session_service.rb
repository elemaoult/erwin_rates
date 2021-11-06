class StripeCheckoutSessionService
  def call(event)
    donation = Donation.find_by(checkout_session_id: event.data.object.id)
    donation.update(state: 'paid')
  end
end
