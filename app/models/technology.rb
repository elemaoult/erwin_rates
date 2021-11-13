class Technology < ApplicationRecord
  has_many :freelancer_technologies, dependent: :destroy
end
