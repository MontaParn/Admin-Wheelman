class RaceEntry < ApplicationRecord
  belongs_to :athlete

  validates :race_name, :race_date, presence: true
end
