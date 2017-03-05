class PresstypeTag < ApplicationRecord

  belongs_to :job, optional: true
  belongs_to :presstype

  strip_attributes

  validates_uniqueness_of :presstype_id, scope: [:job_id]
  validates :presstype_id, presence: true
  validates :job_id, presence: true

  validates_associated :job

end
