class PersonExpertise < ApplicationRecord
  belongs_to :expertise
  belongs_to :person
end
