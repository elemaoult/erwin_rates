class Person < ApplicationRecord
  has_many  :person_technologies 
  has_many  :person_expertises
  has_many  :person_industries

  belongs_to :origin
  
end
