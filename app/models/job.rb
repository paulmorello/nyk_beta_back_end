class Job < ApplicationRecord

  belongs_to :outlet, optional: true, inverse_of: :jobs
  belongs_to :writer, optional: true, inverse_of: :jobs

  has_many :presstype_tags, dependent: :destroy
  has_many :presstypes, :through => :presstype_tags

  has_many :saved_jobs, dependent: :destroy
  has_many :campaigns, :through => :saved_jobs

  validates_uniqueness_of :outlet_id, scope: [:writer_id], :on => :create

  validates :outlet_id, presence: true
  validates :writer, presence: true
  validates :email_work, presence: true
  validates :position, presence: true


  strip_attributes

  accepts_nested_attributes_for :presstype_tags, allow_destroy: true, reject_if: :all_blank

end
