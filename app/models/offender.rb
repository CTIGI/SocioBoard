class Offender < ApplicationRecord
  paginates_per 10
  has_many :measures, dependent: :destroy
  has_and_belongs_to_many :crimes

end
