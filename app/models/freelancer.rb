class Freelancer < ApplicationRecord

  has_many  :freelancer_technologies, dependent: :destroy
  has_many  :freelancer_expertises, dependent: :destroy
  has_many  :freelancer_industries, dependent: :destroy
  
  has_many :technologies, through: :freelancer_technologies, dependent: :destroy
  has_many :expertises, through: :freelancer_expertises, dependent: :destroy
  has_many :industries, through: :freelancer_industries, dependent: :destroy
  
  belongs_to :source
  
  before_update :round_50 
  # scope :from_seed, -> { joins(:source).where('source.seed_valid = ?', false) }

  private

  def round_50
    update_column(:daily_rate_interval, daily_rate.div(50)*50)
  end
end
