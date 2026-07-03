require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  test "active scope excludes expired and cancelled memberships" do
    assert_includes Membership.active, memberships(:alice_active)
    assert_includes Membership.active, memberships(:bob_active)
    assert_not_includes Membership.active, memberships(:alice_expired)
  end

  test "expired scope only includes memberships past end_date" do
    assert_includes Membership.expired, memberships(:alice_expired)
    assert_not_includes Membership.expired, memberships(:alice_active)
  end

  test "expiring_soon scope only includes active memberships within the window" do
    assert_includes Membership.expiring_soon(7), memberships(:alice_active)
    assert_not_includes Membership.expiring_soon(7), memberships(:bob_active)
    assert_not_includes Membership.expiring_soon(7), memberships(:alice_expired)
  end

  test "status reflects cancellation and expiry" do
    assert_equal :active, memberships(:alice_active).status
    assert_equal :expired, memberships(:alice_expired).status

    cancelled = memberships(:bob_active)
    cancelled.cancelled_at = Time.current
    assert_equal :cancelled, cancelled.status
  end

  test "reminder_message includes athlete name and package plan" do
    membership = memberships(:alice_active)
    message = membership.reminder_message

    assert_includes message, membership.athlete.name
    assert_includes message, membership.package_plan.name
  end
end
