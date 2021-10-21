class PersonTechnology < ApplicationRecord
  belongs_to :technology
  belongs_to :person
end
