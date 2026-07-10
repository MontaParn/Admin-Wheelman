class Athlete < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :race_entries, dependent: :destroy
  has_many :event_attendances, dependent: :destroy
  has_many :events, through: :event_attendances
  has_many :payments, through: :memberships
  has_many :reminders, through: :memberships

  validates :name, presence: true
  validates :started_on, presence: true

  scope :active, -> { where(active: true) }

  def current_membership
    memberships.active.order(end_date: :desc).first
  end

  def on_time_payment_rate
    paid = payments.where.not(paid_on: nil)
    return 0.0 if paid.empty?

    on_time = paid.select { |payment| payment.paid_on <= payment.due_on }.size
    on_time.to_f / paid.size
  end

  def race_count_this_year
    race_entries.where(race_date: Date.current.beginning_of_year..Date.current.end_of_year).count
  end

  def tenure_days
    (Date.current - started_on).to_i
  end
end
