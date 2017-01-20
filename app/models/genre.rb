class Genre < ApplicationRecord
  has_many :genre_tags
  has_many :writers, :through => :genre_tags

  strip_attributes
end
