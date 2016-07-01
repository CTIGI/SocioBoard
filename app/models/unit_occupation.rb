require 'csv'

class UnitOccupation < ApplicationRecord
  belongs_to :unit

  scope :ordered_by_date, -> { order("day ASC") }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |uc|
        csv << uc.attributes.values_at(*column_names)
      end
    end
  end
end
