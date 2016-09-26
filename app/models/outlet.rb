class Outlet < ApplicationRecord
  has_and_belongs_to_many :writers
  belongs_to :country

  strip_attributes

  validates :name, presence: true
end
