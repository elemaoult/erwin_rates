class FreelancersController < ApplicationController
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

#   def filtered_freelancers
# #  Get all occurences of params

#     Freelancer.all.select do |freelance| 
#       filter_condition?(freelance)
#     end
#   end

#   def filter_condition?(freelance)
#     condition_expertise?(freelance) && condition_technology?(freelance) && condition_experience?(freelance)
#   end

#   def condition_expertise?(freelance)
#     return true if @filter_expertise == @all_expertises
#     # ary = freelance.expertises.select do |expertise|
#     #   @filter_expertise.include?(expertise.name)
#     # end
#     # !ary.empty?
#     ary = freelance.expertises.map do |expertise|
#       expertise.name
#     end
#     !(@filter_expertise - ary).empty? 
#   end

#   def condition_technology?(freelance)
#     return true if @filter_technology == @all_technologies
#     # ary = freelance.technologies.select do |technology|
#     #   @filter_technology.include?(technology.name)
#     # end
#     # !ary.empty?
#     ary = freelance.technologies.map do |technology|
#       technology.name
#     end
#     !(@filter_technology - ary).empty? 
#   end

  # def condition_experience?(freelance)
  #   return true if @filter_experience == @all_experiences
  #   @filter_experience.include?(freelance.experience) 
  # end

  def get_conditions

    #   Get all possible params
    @all_expertises = Expertise.pluck(:name)
    @all_technologies = Technology.pluck(:name)
    @all_experiences = ["Junior", "Intermédiaire", "Senior"]
    @all_genders = ["Femme", "Homme", "andy"]

    #   Get params from form
    @filter_expertise = params["Expertises"].blank? ? @all_expertises : [params["Expertises"]]
    @filter_technology = params["Technologies"].blank? ? @all_technologies : [params["Technologies"]]
    @filter_experience = params["Seniority"].blank? ? @all_experiences : [params["Seniority"]]
    @filter_gender = params["Gender"].blank? ? @all_experiences : [params["Gender"]]
  end

  def freelancer_expertises_data
    # ary = filtered_freelancers
    
    hsh = Freelancer.joins(:technologies, :expertises).where(technologies:{name: @filter_technology }, expertises: {name: @filter_expertise }, experience: @filter_experience).group(:daily_rate_interval).count
    # [{:daily_rate_interval => "400", :count=>25},{:daily_rate_interval => "500", :count=>50}]
    # {0=>3, 150=>1, 200=>1, 300=>7, 350=>19, 400=>12, 450=>12, 500=>10, 550=>14, 600=>14, 650=>4, 700=>7, 750=>6, 800=>3, 850=>2, 900=>4}
  
    chart_data = []
    hsh.each do |interval, number_of_freelancers|
      chart_data << {:daily_rate_interval => interval, :count=>number_of_freelancers }
    end

    key = hsh.keys.min
    while key < hsh.keys.max
      chart_data << {:daily_rate_interval => key, :count => 0 } if !hsh.keys.include?(key)
      key += 50
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
