class Presstype < ApplicationRecord
  has_many :presstype_tags
  has_many :jobs, :through => :presstype_tags

  strip_attributes

end
