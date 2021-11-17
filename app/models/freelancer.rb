require 'gender_detector'

class Freelancer < ApplicationRecord

  has_many  :freelancer_technologies, dependent: :destroy
  has_many  :freelancer_expertises, dependent: :destroy
  
  has_many :technologies, through: :freelancer_technologies, dependent: :destroy
  has_many :expertises, through: :freelancer_expertises, dependent: :destroy
  
  belongs_to :source
  
  after_save :round_50 
  after_save :add_gender 
  
  def round_50
    update_column(:daily_rate_interval, daily_rate.div(50)*50)
  end

  def add_gender
    d = GenderDetector.new
    gender_guess = d.get_gender(self.first_name).to_s
    # Dealing with obvious type
    gender_guess = "male" if gender_guess == "mostly_male"
    gender_guess = "female" if gender_guess == "mostly_female"
    # Translate into French
    gender_guess = "Andy" if gender_guess == "andy"
    gender_guess = "Homme" if gender_guess == "male" 
    gender_guess = "Femme" if gender_guess == "female" 

    update_column(:gender_guess, gender_guess)
    puts "#{self.first_name}, #{self.gender_guess}"
  end

end
