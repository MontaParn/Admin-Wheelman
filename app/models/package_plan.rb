class PackagePlan < ApplicationRecord
  has_many :memberships, dependent: :restrict_with_error

  BILLING_CYCLE_LABELS = {
    daily: "รายวัน", monthly: "รายเดือน", quarterly: "ราย 3 เดือน", semi_annual: "ราย 6 เดือน", annual: "รายปี"
  }.freeze

  enum :billing_cycle, { monthly: 0, semi_annual: 1, annual: 2, daily: 3, quarterly: 4 }

  validates :name, presence: true
  validates :duration_days, :price, presence: true, numericality: { greater_than: 0 }
  validate :at_least_one_discipline

  scope :active, -> { where(active: true) }

  def disciplines
    [ ("🏃 วิ่ง" if run), ("🏊 ว่ายน้ำ" if swim), ("🚴 ปั่นจักรยาน" if bike) ].compact
  end

  def billing_cycle_label
    BILLING_CYCLE_LABELS.fetch(billing_cycle.to_sym)
  end

  private

  def at_least_one_discipline
    errors.add(:base, "ต้องเลือกอย่างน้อยหนึ่งชนิดกีฬา") unless run? || swim? || bike?
  end
end
