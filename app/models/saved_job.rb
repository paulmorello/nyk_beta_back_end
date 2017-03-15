class SavedJob < ApplicationRecord

  belongs_to :job
  belongs_to :campaign
  default_scope { order('created_at DESC')}

  strip_attributes

  validates :campaign_id, presence: true
  validates :job_id, presence: true


end
