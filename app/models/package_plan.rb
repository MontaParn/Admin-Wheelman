class PackagePlan < ApplicationRecord
  has_many :memberships, dependent: :restrict_with_error

  enum :billing_cycle, { monthly: 0, semi_annual: 1, annual: 2 }

  validates :name, presence: true
  validates :duration_days, :price, presence: true, numericality: { greater_than: 0 }
  validate :at_least_one_discipline

  scope :active, -> { where(active: true) }

  def disciplines
    [ ("วิ่ง" if run), ("ว่ายน้ำ" if swim), ("ปั่นจักรยาน" if bike) ].compact
  end

  private

  def at_least_one_discipline
    errors.add(:base, "ต้องเลือกอย่างน้อยหนึ่งชนิดกีฬา") unless run? || swim? || bike?
  end
end
