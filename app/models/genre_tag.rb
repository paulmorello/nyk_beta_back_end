class GenreTag < ApplicationRecord

  belongs_to :writer, optional: true
  belongs_to :genre

  strip_attributes

  validates_uniqueness_of :genre_id, scope: [:writer_id]
  validates :genre_id, presence: true
  # validates :writer_id, presence: true
end
