class Payment < ApplicationRecord
  belongs_to :membership

  validates :amount, :due_on, presence: true

  scope :paid, -> { where.not(paid_on: nil) }
  scope :pending, -> { where(paid_on: nil) }
  scope :overdue, -> { pending.where(due_on: ...Date.current) }

  def status
    return :paid if paid_on.present?
    due_on < Date.current ? :overdue : :pending
  end

  def on_time?
    paid_on.present? && paid_on <= due_on
  end

  def mark_paid!(paid_on: Date.current)
    update!(paid_on: paid_on)
  end
end
