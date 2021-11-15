class Source < ApplicationRecord
  has_many  :freelancer, dependent: :destroy
end
