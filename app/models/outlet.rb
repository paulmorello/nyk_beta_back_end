class Outlet < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :writers, :through => :jobs
  belongs_to :country

<<<<<<< HEAD

=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  strip_attributes

  validates :name, presence: true, uniqueness: true

end
