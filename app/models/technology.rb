class Technology < ApplicationRecord
  has_many :freelancer_technologies, dependent: :destroy
  has_many :freelancers, through: :freelancer_technologies
end