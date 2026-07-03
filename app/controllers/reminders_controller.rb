class RemindersController < ApplicationController
  def create
    @membership = Membership.find(params[:membership_id])
    success = LineMessenger.push(line_user_id: @membership.athlete.line_user_id, text: @membership.reminder_message)

    @reminder = @membership.reminders.create!(
      channel: :line,
      message_body: @membership.reminder_message,
      sent_at: Time.current,
      status: success ? :sent : :failed
    )

    respond_to do |format|
      format.turbo_stream
      format.html do
        notice = success ? "ส่งข้อความเตือนแล้ว" : "ส่งข้อความไม่สำเร็จ"
        redirect_back fallback_location: root_path, notice: notice
      end
    end
  end
end
