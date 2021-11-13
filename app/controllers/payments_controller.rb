class PaymentsController < ApplicationController
  skip_after_action :verify_authorized
  
  def new
    @donation = current_user.donations.where(state: 'en attente').find(params[:donation_id])
  end

end
