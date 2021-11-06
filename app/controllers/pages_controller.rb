class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :freelancer_expertises_data]
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
    @result = result.values.map{|res| {expertise: res[1], count: res[0]}}
    
  end
  
end
