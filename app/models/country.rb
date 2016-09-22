class Country < ApplicationRecord
  has_many :outlets
  has_many :writers
end
