class FreelancersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:freelancer_expertises_data]
  skip_before_action :verify_authenticity_token, only: :freelancer_expertises_data

  # def index
  #   # @freelancer = Freelancer.all
  #   # # query = "SELECT freelancers.id, FLOOR(freelancers.daily_rate/100)*100 AS TJM FROM FREELANCERS ORDER BY TJM ASC"

  #   # # result = ActiveRecord::Base.connection.execute(query)
  #   # # @result = result.values.map{|res| {daily_rate: res[1], count: res[0]}}
  # end

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
    query = "SELECT freelancers.id, FLOOR(freelancers.daily_rate/100)*100 AS TJM 
    FROM freelancers 
    WHERE freelancers.remote = #{@remote} 
    ORDER BY TJM ASC"
    
    result = ActiveRecord::Base.connection.execute(query)
    @result = result.values.map{|res| {freelancer: res[1], count: res[0]}}
  end

  def filtered_freelancers#(@filter_expertise, @filter_technology, @filter_experience)
#  Get all occurences of params
    @all_expertises = Expertise.pluck(:name)
    @all_technologies = Technology.pluck(:name)
    @all_experiences = ["Junior", "Intermédiaire", "Senior"]
    
    Freelancer.all.select do |freelance| 
      filter_condition?(freelance, @filter_expertise, @filter_technology, @filter_experience)
    end
  end

  def filter_condition?(freelance, filter_expertise, filter_technology, filter_experience)
    filter_experience.include?(freelance.experience) && condition_expertise?(freelance, filter_expertise) && condition_technology?(freelance, filter_technology)
  end

  def condition_expertise?(freelance, filter_expertise)
    ary = freelance.expertises.select do |expertise|
      @filter_expertise.include?(expertise.name)
    end
    ary.empty? ? false : true
  end

  def condition_technology?(freelance, filter_technology)
    ary = freelance.technologies.select do |technology|
      @filter_technology.include?(technology.name)
    end
    ary.empty? ? false : true
  end

  def get_conditions
    #   Get params from form
    @filter_expertise = params["Expertises"].blank? ? @all_expertises : [params["Expertises"]]
    @filter_technology = params["Technologies"].blank? ? @all_technologies : [params["Technologies"]]
    @filter_experience = params["Seniority"].blank? ? @all_experiences : [params["Seniority"]]

    # @filter_expertise = ["Backend", "Frontend"]
    # @filter_technology = ["JavaScript", "CSS"]
    # @filter_experience = ["Senior"]  

    return [@filter_expertise,@filter_technology, @filter_experience]
  end

  def freelancer_expertises_data

    ary = get_conditions
    @filter_expertise = ary[0]
    @filter_technology = ary[1]
    @filter_experience = ary[2]

    ary = filtered_freelancers#(@filter_expertise, @filter_technology, @filter_experience)

    # [{:daily_rate_interval => "400", :count=>25},{:daily_rate_interval => "500", :count=>50}]
    result = ary.group_by { |freelancer| freelancer.daily_rate }

    chart_data = result.map do |freelance_group|
      {:daily_rate => freelance_group.first, :count=>freelance_group.count }
    end

    respond_to do |format|
      format.all {render json: {result: chart_data}}
    end
    
  end


end
