class Expertise < ApplicationRecord
  has_many :freelancer_expertises, dependent: :destroy
  has_many :freelancers, through: :freelancer_expertises

  validates :name, uniqueness: { case_sensitive: false }

end
