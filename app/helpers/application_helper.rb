module ApplicationHelper
  FIELD_LABEL_CLASS = "block text-sm font-semibold text-gray-900"
  FIELD_INPUT_CLASS = "mt-1.5 block w-full rounded-xl border border-gray-300 px-4 py-2.5 text-sm text-gray-900 " \
    "placeholder-gray-400 shadow-sm focus:outline-none focus:ring-2 focus:ring-gray-900 focus:border-gray-900"

  def field_label_class
    FIELD_LABEL_CLASS
  end

  def field_input_class
    FIELD_INPUT_CLASS
  end

  def field_helper_text(text)
    content_tag :p, text, class: "mt-1.5 text-xs text-gray-500"
  end

  MEMBERSHIP_STATUS_LABELS = {
    active: "ปกติ", expired: "หมดอายุ", cancelled: "ยกเลิก", pending_payment: "ค้างชำระ"
  }.freeze
  MEMBERSHIP_STATUS_CLASSES = {
    active: "bg-green-100 text-green-800",
    expired: "bg-red-100 text-red-800",
    cancelled: "bg-gray-100 text-gray-600",
    pending_payment: "bg-orange-100 text-orange-800"
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
