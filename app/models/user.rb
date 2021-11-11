class User < ApplicationRecord
<<<<<<< HEAD
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :donations
=======
  validates :nickname, presence: true
>>>>>>> d16124d1ffa89b138cc750467aa9ddab12eed7c7
end
