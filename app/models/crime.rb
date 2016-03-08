class Crime < ApplicationRecord
  has_and_belongs_to_many :offenders
end
