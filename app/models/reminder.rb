class Reminder < ApplicationRecord
  belongs_to :membership

  enum :channel, { line: 0 }
  enum :status, { sent: 0, failed: 1 }

  validates :message_body, presence: true

  scope :sent_today, -> { where(sent_at: Date.current.all_day) }
end
