class SendMembershipRemindersJob < ApplicationJob
  queue_as :default

  def perform
    Membership.expiring_soon.includes(:athlete, :package_plan).find_each do |membership|
      next if membership.reminders.sent_today.exists?

      success = LineMessenger.push(line_user_id: membership.athlete.line_user_id, text: membership.reminder_message)

      membership.reminders.create!(
        channel: :line,
        message_body: membership.reminder_message,
        sent_at: Time.current,
        status: success ? :sent : :failed
      )
    end
  end
end
