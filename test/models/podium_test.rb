require "test_helper"

class PodiumTest < ActiveSupport::TestCase
  test "by_tenure ranks athletes with the earliest started_on first" do
    ranking = Podium.by_tenure
    assert_equal [ athletes(:alice), athletes(:bob) ], ranking.to_a
  end

  test "by_punctuality ranks athletes with the highest on-time payment rate first" do
    ranking = Podium.by_punctuality
    assert_equal athletes(:bob), ranking.first
    assert_equal athletes(:alice), ranking.second
  end

  test "by_race_count ranks athletes with the most races this year first" do
    ranking = Podium.by_race_count
    assert_equal athletes(:alice), ranking.first
    assert_equal athletes(:bob), ranking.second
  end
end
