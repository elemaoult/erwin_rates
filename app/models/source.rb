class Source < ApplicationRecord
  has_many  :freelancers, dependent: :destroy
end
