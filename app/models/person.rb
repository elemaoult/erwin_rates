class Person < ApplicationRecord
  has_many  :person_technologies, 
            :person_expertises,
            :person_industries
  belongs_to :origin
end
