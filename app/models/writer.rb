class Writer < ApplicationRecord
  has_and_belongs_to_many :outlets
  belongs_to :country
end
