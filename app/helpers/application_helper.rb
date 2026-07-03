module ApplicationHelper
  MEMBERSHIP_STATUS_LABELS = { active: "ปกติ", expired: "หมดอายุ", cancelled: "ยกเลิก" }.freeze
  MEMBERSHIP_STATUS_CLASSES = {
    active: "bg-green-100 text-green-800",
    expired: "bg-red-100 text-red-800",
    cancelled: "bg-gray-100 text-gray-600"
  }.freeze

  def membership_status_badge(membership)
    status = membership.status
    status = :expiring_soon if status == :active && membership.days_until_expiry <= 7
    classes = status == :expiring_soon ? "bg-yellow-100 text-yellow-800" : MEMBERSHIP_STATUS_CLASSES.fetch(status)
    label = status == :expiring_soon ? "ใกล้หมดอายุ" : MEMBERSHIP_STATUS_LABELS.fetch(status)

    content_tag :span, label, class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium #{classes}"
  end

  def payment_status_badge(payment)
    status = payment.status
    classes = {
      paid: "bg-green-100 text-green-800",
      overdue: "bg-red-100 text-red-800",
      pending: "bg-yellow-100 text-yellow-800"
    }.fetch(status)
    label = { paid: "จ่ายแล้ว", overdue: "เกินกำหนด", pending: "รอชำระ" }.fetch(status)

    content_tag :span, label, class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium #{classes}"
  end
end
