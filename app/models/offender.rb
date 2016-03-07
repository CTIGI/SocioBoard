class Offender < ApplicationRecord
  paginates_per 10
  has_many :measures, dependent: :destroy
end
