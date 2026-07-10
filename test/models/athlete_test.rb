require "test_helper"

class AthleteTest < ActiveSupport::TestCase
  test "on_time_payment_rate mixes on-time and late payments" do
    # alice: one on-time payment, one late payment
    assert_in_delta 0.5, athletes(:alice).on_time_payment_rate, 0.01
    # bob: single on-time payment
    assert_in_delta 1.0, athletes(:bob).on_time_payment_rate, 0.01
  end

  test "on_time_payment_rate is zero when no payments have been made" do
    athlete = Athlete.create!(name: "New Athlete", started_on: Date.current)
    assert_equal 0.0, athlete.on_time_payment_rate
  end

  test "race_count_this_year counts only races within the current year" do
    assert_equal 2, athletes(:alice).race_count_this_year
    assert_equal 1, athletes(:bob).race_count_this_year
  end

  test "current_membership returns the active membership" do
    assert_equal memberships(:alice_active), athletes(:alice).current_membership
  end
end
