class Country < ApplicationRecord
  has_many :outlets
  has_many :writers

  strip_attributes
end
