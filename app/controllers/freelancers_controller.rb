class FreelancersController < ApplicationController
    def new
    @freelancer = Freelancer.new
  end

  def create
    @freelancer = Freelancer.new(params[:freelancer])
    @freelancer.save!
    redirect_to freelancer_path(@freelancer)
  end
  
  def destroy
  end

  def freelancer_params
    params.require(:freelancer).permit(:first_name, :last_name, :location, :job_description, :experience, :daily_rate, :currency)
end

end
