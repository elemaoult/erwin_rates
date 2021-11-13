class PaymentsController < ApplicationController
  skip_after_action :verify_authorized
  
  def new
    @donation = Donation.find(params[:donation_id])
  end

end
