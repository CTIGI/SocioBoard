class UnitOccupation < ApplicationRecord
  belongs_to :unit

  scope :ordered_by_date, -> { order("day ASC") }
end
