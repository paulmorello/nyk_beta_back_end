class Writer < ApplicationRecord
  has_and_belongs_to_many :outlets
  belongs_to :country
  accepts_nested_attributes_for :outlets, allow_destroy: true

  strip_attributes

end
