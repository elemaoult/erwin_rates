class PagesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: :freelancer_expertises_data
  

  def home
    @expertises = []
    FreelancerExpertise
    
    query = "SELECT COUNT(freelancer_expertises.id), expertises.name
    FROM freelancer_expertises
    INNER JOIN expertises ON freelancer_expertises.expertise_id = expertises.id
    GROUP BY expertises.name
     "
    result = ActiveRecord::Base.connection.execute(query)
    # [{:expertise=>"UX/UI Designer", :count=>389}, {:expertise=>"DevOps / Cloud", :count=>137}, {:expertise=>"Backend", :count=>976}, {:expertise=>"Frontend", :count=>132}]
    @result = result.values.map{|res| {expertise: res[1], count: res[0]}}
    
  end

  def freelancer_expertises_data
    @expertises = []
    FreelancerExpertise
    query = "SELECT COUNT(freelancer_expertises.id), expertises.name
    FROM freelancer_expertises
    INNER JOIN expertises ON freelancer_expertises.expertise_id = expertises.id
    GROUP BY expertises.name"
    result = ActiveRecord::Base.connection.execute(query)
    @result = result.values.map{|res| {expertise: res[1], count: res[0]}}

    respond_to do |format|
      format.all {render json: {result: @result}}
    end
    
  end

  def contact_form
    contact_infos = {
      name: params[:contact][:name], 
      email: params[:contact][:email],
      subject: params[:contact][:subject],
      message: params[:contact][:message]
    }
    ContactMailer.notify(contact_infos).deliver_now
    redirect_to root_path
  end

end
