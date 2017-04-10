class SavedJob < ApplicationRecord

  belongs_to :job
  belongs_to :campaign
<<<<<<< HEAD
  default_scope { order('created_at DESC')}
=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931

  strip_attributes

  validates :campaign_id, presence: true
  validates :job_id, presence: true


end
