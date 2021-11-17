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

  def get_conditions

    #   Get all possible params
    @all_expertises = Expertise.pluck(:name).uniq
    @all_technologies = Technology.pluck(:name).uniq
    @all_experiences = Freelancer.pluck(:experience).uniq
    @all_genders = Freelancer.pluck(:gender_guess).uniq
    @all_remotes = Freelancer.pluck(:remote).uniq

    #   Get params from form
    @filter_expertise = params["Expertises"].blank? ? @all_expertises : [params["Expertises"]]
    @filter_technology = params["Technologies"].blank? ? @all_technologies : [params["Technologies"]]
    @filter_experience = params["Seniority"].blank? ? @all_experiences : [params["Seniority"]]
    @filter_gender = params["Gender"].blank? ? @all_genders : [params["Gender"]]
    @filter_remote = params["Remote"].blank? ? @all_remotes : ( [params["Remote"]] == ["Présentiel"] ? false : true )

  end

  def freelancer_expertises_data  
    
    @big_joined_table = Freelancer.joins(:technologies, :expertises).where(experience: @filter_experience, gender_guess: @filter_gender, remote: @filter_remote, technologies:{name: @filter_technology }, expertises: {name: @filter_expertise }).distinct

    # Creating graph

    hsh = @big_joined_table.group(:daily_rate_interval).count
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

      # Calculating figures on search_page
      # This is not the right resul - I do not know why
      @nb_freelancers = @big_joined_table.count
      @avg_daily_rate = @big_joined_table.collect(&:daily_rate).sum/@nb_freelancers
      @median_daily_rate =  @big_joined_table.collect(&:daily_rate).sort[@nb_freelancers/2]
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
