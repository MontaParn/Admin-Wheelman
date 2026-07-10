require "test_helper"

class EventAttendanceTest < ActiveSupport::TestCase
  test "an athlete cannot attend the same event twice" do
    duplicate = EventAttendance.new(event: events(:triathlon_camp), athlete: athletes(:alice))

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:athlete_id], "has already been taken"
  end
end
