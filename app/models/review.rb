class Review < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :email, presence: true
end
