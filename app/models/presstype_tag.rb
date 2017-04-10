class PresstypeTag < ApplicationRecord

<<<<<<< HEAD
  belongs_to :job, optional: true
=======
  belongs_to :job
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  belongs_to :presstype

  strip_attributes

  validates_uniqueness_of :presstype_id, scope: [:job_id]
  validates :presstype_id, presence: true
<<<<<<< HEAD
  # validates :job_id, presence: true
  
  validates_associated :job
=======
  validates :job_id, presence: true

  # validates_associated :job
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931

end
