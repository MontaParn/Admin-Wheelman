class Event < ApplicationRecord
  has_one_attached :photo
  has_many :event_attendances, dependent: :destroy
  has_many :athletes, through: :event_attendances

  enum :category, { race: 0, camp: 1 }

  validates :name, :start_date, :end_date, presence: true
  validates :google_map_link, format: { with: %r{\Ahttps?://\S+\z}, message: "ต้องขึ้นต้นด้วย http:// หรือ https://" },
    allow_blank: true
  validate :at_least_one_discipline
  validate :end_date_not_before_start_date

  scope :in_year, ->(year) { where(start_date: Date.new(year, 1, 1)..Date.new(year, 12, 31)) }

  def disciplines
    [ ("🏃 วิ่ง" if run), ("🏊 ว่ายน้ำ" if swim), ("🚴 ปั่นจักรยาน" if bike) ].compact
  end

  def single_day?
    start_date == end_date
  end

  private

  def at_least_one_discipline
    errors.add(:base, "ต้องเลือกอย่างน้อยหนึ่งชนิดกีฬา") unless run? || swim? || bike?
  end

  def end_date_not_before_start_date
    return if start_date.blank? || end_date.blank?
    errors.add(:end_date, "ต้องไม่ก่อนวันที่เริ่ม") if end_date < start_date
  end
end
