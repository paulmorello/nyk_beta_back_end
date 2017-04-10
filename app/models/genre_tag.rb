class GenreTag < ApplicationRecord

<<<<<<< HEAD
  belongs_to :writer, optional: true
=======
  belongs_to :writer
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  belongs_to :genre

  strip_attributes

  validates_uniqueness_of :genre_id, scope: [:writer_id]
  validates :genre_id, presence: true
<<<<<<< HEAD
  # validates :writer_id, presence: true
=======
  validates :writer_id, presence: true
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931

end
