class FreelancersController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:freelancer_expertises_data]
  skip_before_action :verify_authenticity_token, only: :freelancer_expertises_data
  before_action :get_conditions
  # before_action :add_daily_rate_interval_to_data

  # def index
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

  def remote_filter
    query = "SELECT freelancers.id, FLOOR(freelancers.daily_rate/100)*100 AS TJM 
    FROM freelancers 
    WHERE freelancers.remote = #{@remote} 
    ORDER BY TJM ASC"
    
    result = ActiveRecord::Base.connection.execute(query)
    @result = result.values.map{|res| {freelancer: res[1], count: res[0]}}
  end

  def filtered_freelancers
#  Get all occurences of params

    Freelancer.all.select do |freelance| 
      filter_condition?(freelance)
    end
  end

  def filter_condition?(freelance)
    @filter_experience.include?(freelance.experience) && condition_expertise?(freelance) && condition_technology?(freelance)
  end

  def condition_expertise?(freelance)
    ary = freelance.expertises.select do |expertise|
      @filter_expertise.include?(expertise.name)
    end
    !ary.empty?
  end

  def condition_technology?(freelance)
    ary = freelance.technologies.select do |technology|
      @filter_technology.include?(technology.name)
    end
    !ary.empty?
  end

  def get_conditions

    #   Get all possible params
    @all_expertises = Expertise.pluck(:name)
    @all_technologies = Technology.pluck(:name)
    @all_experiences = ["Junior", "Intermédiaire", "Senior"]

    #   Get params from form
    @filter_expertise = params["Expertises"].blank? ? @all_expertises : [params["Expertises"]]
    @filter_technology = params["Technologies"].blank? ? @all_technologies : [params["Technologies"]]
    @filter_experience = params["Seniority"].blank? ? @all_experiences : [params["Seniority"]]

  end

  def freelancer_expertises_data
    ary = filtered_freelancers
    
    # [{:daily_rate_interval => "400", :count=>25},{:daily_rate_interval => "500", :count=>50}]
    result = ary.group_by { |freelancer| freelancer.daily_rate_interval }

    chart_data = result.map do |freelance_group|
      {:daily_rate_interval => freelance_group[0], :count=>freelance_group[1].count }
    end

    chart_data.sort_by! { |hsh| hsh[:daily_rate_interval] }

    respond_to do |format|
      format.html
      format.json { render json: { result: chart_data } }
    end

  end

  # Run this command only once in heroku
  def add_daily_rate_interval_to_data
    Freelancer.all.each do |freelancer|
      if freelancer.daily_rate_interval.blank?
        freelancer.daily_rate_interval = freelancer.daily_rate.div(50) 
        freelancer.save
      end
    end
  end

  private
  # TODO => put private methods under there (private methods are methods that are called only from within the class they exist in, and shouldn't be exposed unnecessarily)

  def freelancer_params
    params.require(:freelancer).permit(:first_name, :last_name, :location, :job_description, :experience, :daily_rate)
  end

end
