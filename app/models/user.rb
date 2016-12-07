class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  strip_attributes

  has_many :writers
  has_many :campaigns, dependent: :destroy
  has_many :saved_jobs, :through => :campaigns

end
