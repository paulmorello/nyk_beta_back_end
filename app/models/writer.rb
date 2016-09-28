class Writer < ApplicationRecord
  has_and_belongs_to_many :outlets
  belongs_to :country

  strip_attributes

  validates :f_name, presence: true
  validates :l_name, presence: true
  validates :email_work, presence: true, uniqueness: true

end
