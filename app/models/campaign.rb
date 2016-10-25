class Campaign < ApplicationRecord

  belongs_to :user
  has_many :saved_jobs, dependent: :destroy
  has_many :jobs, :through => :saved_jobs

  strip_attributes

  validates :name, presence: true

end
