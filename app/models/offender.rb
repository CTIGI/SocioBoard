class Offender < ApplicationRecord
  paginates_per 10
  has_many :measures, dependent: :destroy
  has_and_belongs_to_many :crimes, -> { distinct }
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

  def self.render_data_list(field)
    data = [[I18n.t("app.no_record"), I18n.t("app.no_record")]]
    self.pluck(field).each do |field_name|
      data << [field_name, field_name] unless data.include?([field_name, field_name]) || field_name.blank? || field_name == I18n.t("app.no_record")
    end
    data
  end

  ransacker :crimes_names do
    Arel::Nodes::SqlLiteral.new "offenders.crimes::varchar"
  end

  ransacker :scope_units do
    Arel::Nodes::SqlLiteral.new "offenders.unit"
  end

end
