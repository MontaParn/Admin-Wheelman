class EventAttendance < ApplicationRecord
  belongs_to :event
  belongs_to :athlete

  validates :athlete_id, uniqueness: { scope: :event_id }
end
