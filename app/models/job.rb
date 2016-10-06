class Job < ApplicationRecord

  belongs_to :outlet
  belongs_to :writer

  validates_uniqueness_of :outlet_id, scope: [:writer_id]
  validates :outlet_id, presence: true
  validates :writer_id, presence: true
  validates :email_work, presence: true
  validates :position, presence: true

end
