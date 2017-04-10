class User < ApplicationRecord
<<<<<<< HEAD

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User


=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931

  strip_attributes

  has_many :writers
  has_many :campaigns, dependent: :destroy
  has_many :saved_jobs, :through => :campaigns

end
