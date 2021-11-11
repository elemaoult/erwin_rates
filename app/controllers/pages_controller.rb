class PagesController < ApplicationController
<<<<<<< HEAD
  skip_before_action :authenticate_user!, only: [:home, :freelancer_expertises_data, :cgu, :legalspecs, :persospecs]
  skip_before_action :verify_authenticity_token, only: :freelancer_expertises_data
  
=======

>>>>>>> d16124d1ffa89b138cc750467aa9ddab12eed7c7
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

    puts "\n\n\n\n\n\n#{@result}\n\n\n\n\n\n"
    respond_to do |format|
      format.all {render json: {result: @result}}
    end
    
  end

end
