class Offender < ApplicationRecord
  paginates_per 10
  has_many :measures, dependent: :destroy
  has_and_belongs_to_many :crimes

  scope :duplicated, -> { where(duplicated: true) }

  def self.crimes_list
    all_crimes_list = []
    self.order(:crimes).pluck("crimes").each do |crimes|
      crimes.each do |c|
        all_crimes_list << [c, c] unless all_crimes_list.include?([c, c])
      end
    end

    all_crimes_list.sort
  end

  ransacker :crimes_names do
    Arel::Nodes::SqlLiteral.new "offenders.crimes::varchar"
  end
end
