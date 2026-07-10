require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "requires at least one discipline" do
    event = Event.new(
      name: "Test", category: :race, start_date: Date.current, end_date: Date.current,
      run: false, swim: false, bike: false
    )

    assert_not event.valid?
    assert_includes event.errors[:base], "ต้องเลือกอย่างน้อยหนึ่งชนิดกีฬา"
  end

  test "end_date cannot be before start_date" do
    event = events(:trail_race)
    event.end_date = event.start_date - 1.day

    assert_not event.valid?
    assert_includes event.errors[:end_date], "ต้องไม่ก่อนวันที่เริ่ม"
  end

  test "in_year scope only includes events starting in that year" do
    assert_includes Event.in_year(Date.current.year), events(:triathlon_camp)
    assert_includes Event.in_year(Date.current.year), events(:trail_race)
    assert_not_includes Event.in_year(Date.current.year), events(:last_years_race)
  end

  test "single_day? is true only when start and end date match" do
    assert events(:trail_race).single_day?
    assert_not events(:triathlon_camp).single_day?
  end

  test "athletes returns attendees through event_attendances" do
    assert_includes events(:triathlon_camp).athletes, athletes(:alice)
    assert_includes events(:triathlon_camp).athletes, athletes(:bob)
  end

  test "google_map_link must be a plain http(s) URL" do
    event = events(:trail_race)

    event.google_map_link = "javascript:alert(1)"
    assert_not event.valid?

    event.google_map_link = "https://maps.google.com/place/xyz"
    assert event.valid?
  end
end
