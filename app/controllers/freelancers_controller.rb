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

  def filtered_freelancers(filter_expertise, filter_technology, filter_experience)
    
    res = Freelancer.all

#  Get all occurences of params
    all_expertises = Expertise.pluck(:name)
    all_technologies = Technology.pluck(:name)
    all_experiences = ["Junior", "Intermédiaire", "Senior"]
    
    res = filtered_freelancers.select do |freelance| 
      filter_condition?(freelance, filter_expertise, filter_technology, filter_experience)
    end

    return res
    
  end

  def filter_condition?(freelance, filter_expertise, filter_technology, filter_experience)
    filter_experience.include?(freelance.experience) && condition_expertise?(freelance, filter_expertise) && condition_technology?(freelance, filter_technology)
  end

  def condition_expertise?(freelance, filter_expertise)
    ary = freelance.expertises.select do |expertise|
      filter_expertise.include?(expertise.name)
    end
    ary.empty? ? false : true
  end

  def condition_technology?(freelance, filter_technology)
    ary = freelance.technologies.select do |technology|
      filter_technology.include?(technology.name)
    end
    ary.empty? ? false : true
  end

  def get_conditions
  
    #   Get params from form
    # filter_expertise = params[:expertise].blank? ? all_expertises : params[:expertise]
    # filter_technology = params[:technology].blank? ? all_technologies : params[:technology]
    # filter_experience = params[:experience].blank? ? all_experiences : params[:experience]  

    filter_expertise = ["Backend", "Frontend"]
    filter_technology = ["JavaScript", "CSS"]
    filter_experience = ["Senior"]  

    return [filter_expertise,filter_technology, filter_experience]

  end

  def freelancer_expertises_data

    ary = get_conditions
    filter_expertise = ary[0]
    filter_technology = ary[1]
    filter_experience = ary[2]

    binding.pry

    ary = filtered_freelancers(filter_expertise, filter_technology, filter_experience)

    @result = ary.group_by { |freelancer| freelancer.daily_rate_interval }
    
    # query = "SELECT COUNT(*) 
    # FROM #{filtered_freelancers} 
    # GROUP BY daily_rate_interval"

    # result = ActiveRecord::Base.connection.execute(query)
    # @result = result.values.map{|res| {expertise: res[1], count: res[0]}}

    respond_to do |format|
      format.all {render json: {result: @result}}
    end
    
  end


end
