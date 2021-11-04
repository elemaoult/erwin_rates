class FreelancersController < ApplicationController

  def index
    @freelancer = Freelancer.all
    query = "SELECT FREELANCERS.ID, FLOOR(FREELANCERS.DAILY_RATE/100)*100 AS TJM FROM FREELANCERS ORDER BY TJM ASC"

    result = ActiveRecord::Base.connection.execute(query)
    @result = result.values.map{|res| {daily_rate: res[1], count: res[0]}}
  end

  def new
    @freelancer = Freelancer.new
  end

  def create
    @freelancer = Freelancer.new(params[:freelancer])
    @freelancer.save!
    redirect_to freelancer_path(@freelancer)
  end

  def destroy
    @freelancer = Freelancer.find(params[:id])
    @freelancer.destroy
    redirect_to freelancers_path
  end

  def freelancer_params
    params.require(:freelancer).permit(:first_name, :last_name, :location, :job_description, :experience, :daily_rate)
  end

  def remote_filter
    query = "SELECT FREELANCERS.ID, FLOOR(FREELANCERS.DAILY_RATE/100)*100 AS TJM FROM FREELANCERS 
    WHERE FREELANCERS.REMOTE = #{@REMOTE} ORDER BY TJM ASC"
    
    result = ActiveRecord::Base.connection.execute(query)
    @result = result.values.map{|res| {freelancer: res[1], count: res[0]}}
  end

  def filter_expertise
    query = "SELECT FREELANCERS.ID, FLOOR(FREELANCERS.DAILY_RATE/100)*100 AS TJM FROM FREELANCERS, FREELANCER_EXPERTISES
    INNER JOIN expertises ON freelancer_expertises.expertise_id = expertises.id
    WHERE FREELANCERS.EXPERTISE_ID = #{@expertise} ORDER BY TJM ASC"

    result = ActiveRecord::Base.connection.execute(query)
    @result = result.values.map{|res| {expertise: res[1], count: res[0]}}
  end
  
  def filter_technologies
  end

  def filter_seniority

  end

end
