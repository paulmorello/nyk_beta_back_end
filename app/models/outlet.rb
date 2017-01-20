class Outlet < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :writers, :through => :jobs
  belongs_to :country

  strip_attributes

  validates :name, presence: true, uniqueness: true

end
