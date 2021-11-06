class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  
  def new
    @donation = current_user.donations.where(state: 'en attente').find(params[:donation_id])
  end

end
