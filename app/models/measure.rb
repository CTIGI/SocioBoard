class Measure < ApplicationRecord
  belongs_to :offender

  def self.render_data_list(field)
    data = []
    self.pluck(field).each do |field_name|
      data << [field_name, field_name] unless data.include?([field_name, field_name]) || field_name.blank?
    end
    data
  end
end
