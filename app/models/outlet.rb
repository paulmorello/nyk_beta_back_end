class Outlet < ApplicationRecord
  has_and_belongs_to_many :writers
end
