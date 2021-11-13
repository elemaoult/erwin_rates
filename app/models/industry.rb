class Industry < ApplicationRecord
  has_many :freelancer_industries, dependent: :destroy
end
