class Freelancer < ApplicationRecord
  has_many  :freelancer_technologies
  has_many  :freelancer_expertises
  has_many  :freelancer_industries

  belongs_to :source

  # scope :from_seed, -> { joins(:source).where('source.seed_valid = ?', false) }
  
end
