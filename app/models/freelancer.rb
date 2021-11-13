class Freelancer < ApplicationRecord
  has_many  :freelancer_technologies, dependent: :destroy
  has_many  :freelancer_expertises, dependent: :destroy
  has_many  :freelancer_industries, dependent: :destroy
  
  has_many :technologies, through: :freelancer_technologies, dependent: :destroy
  has_many :expertises, through: :freelancer_expertises, dependent: :destroy
  has_many :industries, through: :freelancer_industries, dependent: :destroy
  
  belongs_to :source
  
  before_commit :round_50, only: %i[create update]
  # scope :from_seed, -> { joins(:source).where('source.seed_valid = ?', false) }

  def get_technology(freelancer)
    res = []
    freelancer.technologies.each do |technology|
      res << technology.name
    end
    return res
  end

  def get_expertise(freelancer)
    res = []
    freelancer.expertises.each do |expertise|
      res << expertise.name
    end
    return res
  end

  def get_industry(freelancer)
    res = []
    freelancer.industries.each do |industry|
      res << industry.name
    end
    return res
  end

  private

  def round_50
    update_column(:daily_rate_interval, daily_rate.div(50)*50)
  end
end
