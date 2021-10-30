class Expertise < ApplicationRecord
  has_many :freelancer_expertises

  validates :name, uniqueness: { case_sensitive: false }

end
