class Expertise < ApplicationRecord
  has_many :freelancer_expertises, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }

end
