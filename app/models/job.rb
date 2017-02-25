class Job < ApplicationRecord

  belongs_to :outlet
  belongs_to :writer

  has_many :presstype_tags, dependent: :destroy
  has_many :presstypes, :through => :presstype_tags

  has_many :saved_jobs, dependent: :destroy
  has_many :campaigns, :through => :saved_jobs

  validates_uniqueness_of :outlet_id, scope: [:writer_id]
  validates :outlet_id, presence: true
  validates :writer, presence: true, inactive: false
  validates :email_work, presence: true
  validates :position, presence: true


  strip_attributes

  accepts_nested_attributes_for :presstype_tags, allow_destroy: true, reject_if: :all_blank

end
