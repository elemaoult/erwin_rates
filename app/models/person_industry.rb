class PersonIndustry < ApplicationRecord
  belongs_to :industry
  belongs_to :person
end
