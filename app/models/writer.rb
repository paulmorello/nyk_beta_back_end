class Writer < ApplicationRecord
  has_many :jobs, dependent: :destroy, inverse_of: :writer
  has_many :outlets, :through => :jobs
  belongs_to :country
  belongs_to :user

  has_many :genre_tags, dependent: :destroy
  has_many :genres, :through => :genre_tags

  strip_attributes

  validates :f_name, presence: true
  validates :l_name, presence: true

  validates :jobs, presence: true

  accepts_nested_attributes_for :genre_tags, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :jobs, allow_destroy: true, reject_if: :all_blank
end
