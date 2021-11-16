class Freelancer < ApplicationRecord

  has_many  :freelancer_technologies, dependent: :destroy
  has_many  :freelancer_expertises, dependent: :destroy
  
  has_many :technologies, through: :freelancer_technologies, dependent: :destroy
  has_many :expertises, through: :freelancer_expertises, dependent: :destroy
  
  belongs_to :source
  
  after_save :round_50 

  
  def round_50
    update_column(:daily_rate_interval, daily_rate.div(50)*50)
  end
end
