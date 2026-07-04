module ApplicationHelper
  FIELD_LABEL_CLASS = "block text-sm font-semibold text-gray-900"
  FIELD_INPUT_CLASS = "mt-1.5 block w-full rounded-xl border-2 border-gray-200 px-4 py-2.5 text-sm text-gray-900 " \
    "placeholder-gray-400 shadow-sm focus:outline-none focus:border-green-600"

  def field_label_class
    FIELD_LABEL_CLASS
  end

  def field_input_class
    FIELD_INPUT_CLASS
  end

  def field_select_class
    "#{FIELD_INPUT_CLASS} field-select"
  end

  def field_helper_text(text)
    content_tag :p, text, class: "mt-1.5 text-xs text-gray-500"
  end

  DISCIPLINE_ICON_CLASSES = {
    run: "bg-green-100", swim: "bg-blue-100", bike: "bg-orange-100"
  }.freeze

  def discipline_toggle(form, attribute, icon, label_text)
    content_tag :label, class:
      "relative flex items-center gap-2 rounded-xl border-2 border-gray-200 bg-white px-3 py-1.5 " \
      "cursor-pointer transition-colors hover:border-gray-300 has-[:checked]:border-green-600" do
      concat form.check_box(attribute, class: "sr-only")
      concat content_tag(:span, icon, class:
        "flex h-6 w-6 shrink-0 items-center justify-center rounded-full text-sm #{DISCIPLINE_ICON_CLASSES.fetch(attribute)}")
      concat content_tag(:span, label_text, class: "text-xs font-medium text-gray-700")
    end
  end

  def back_link(path)
    link_to path, class: "mb-4 inline-flex items-center gap-1 text-sm font-medium text-gray-600 hover:text-green-700" do
      "&larr; กลับ".html_safe
    end
  end

  def toggle_switch(form, attribute, label_text)
    content_tag :label, class: "inline-flex items-center gap-3 cursor-pointer" do
      concat form.check_box(attribute, class: "peer sr-only")
      concat content_tag(:span, "", class:
        "relative h-6 w-11 shrink-0 rounded-full bg-gray-300 transition-colors peer-checked:bg-green-600 " \
        "after:absolute after:left-1 after:top-1 after:h-4 after:w-4 after:rounded-full after:bg-white " \
        "after:transition-transform after:content-[''] peer-checked:after:translate-x-5")
      concat content_tag(:span, label_text, class: "text-sm text-gray-700")
    end
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
