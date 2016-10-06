class PresstypeTag < ApplicationRecord

  belongs_to :writer
  belongs_to :presstype

  strip_attributes

  validates_uniqueness_of :presstype_id, scope: [:writer_id]
  validates :presstype_id, presence: true
  validates :writer_id, presence: true

end
