class Membership < ApplicationRecord
  belongs_to :athlete
  belongs_to :package_plan
  has_many :payments, dependent: :destroy
  has_many :reminders, dependent: :destroy

  validates :start_date, :end_date, :price_paid, presence: true

  scope :not_cancelled, -> { where(cancelled_at: nil) }
  scope :active, -> { not_cancelled.where(end_date: Date.current..) }
  scope :expired, -> { not_cancelled.where(end_date: ...Date.current) }
  scope :expiring_soon, ->(days = 7) { active.where(end_date: ..(Date.current + days)) }

  def cancelled?
    cancelled_at.present?
  end

  def status
    return :cancelled if cancelled?
    end_date < Date.current ? :expired : :active
  end

  def days_until_expiry
    (end_date - Date.current).to_i
  end

  def reminder_message
    "สวัสดีครับ คุณ#{athlete.name} แพคเกจ \"#{package_plan.name}\" ของคุณจะหมดอายุวันที่ " \
      "#{end_date.strftime('%d/%m/%Y')} กรุณาชำระเงิน #{price_paid.to_i} บาท เพื่อต่ออายุนะครับ"
  end
end
