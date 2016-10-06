class Writer < ApplicationRecord
  has_many :jobs
  has_many :outlets, :through => :jobs
  belongs_to :country
  belongs_to :user

  has_many :genre_tags
  has_many :genres, :through => :genre_tags

  has_many :presstype_tags
  has_many :presstypes, :through => :presstype_tags

  strip_attributes

  validates :f_name, presence: true
  validates :l_name, presence: true

  accepts_nested_attributes_for :genre_tags, allow_destroy: true, reject_if: :all_blank

end
