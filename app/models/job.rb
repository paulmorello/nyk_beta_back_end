class Job < ApplicationRecord

  belongs_to :outlet
  belongs_to :writer

  has_many :presstype_tags, dependent: :destroy
  has_many :presstypes, :through => :presstype_tags

  validates_uniqueness_of :outlet_id, scope: [:writer_id]
  validates :outlet_id, presence: true
  validates :writer, presence: true
  validates :email_work, presence: true
  validates :position, presence: true

  # validates_associated :writer

  strip_attributes

  accepts_nested_attributes_for :presstype_tags, allow_destroy: true, reject_if: :all_blank

end
