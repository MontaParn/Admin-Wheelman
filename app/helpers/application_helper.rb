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

  EVENT_CATEGORY_LABELS = { race: "Race", camp: "Camp" }.freeze
  EVENT_CATEGORY_TOGGLE_CLASSES = {
    race: "has-[:checked]:border-green-600 has-[:checked]:bg-green-50 has-[:checked]:text-green-700",
    camp: "has-[:checked]:border-orange-500 has-[:checked]:bg-orange-50 has-[:checked]:text-orange-700"
  }.freeze
  EVENT_CATEGORY_BADGE_CLASSES = {
    race: "bg-green-100 text-green-800", camp: "bg-orange-100 text-orange-800"
  }.freeze

  def category_toggle(form, value)
    content_tag :label, class:
      "rounded-xl border-2 border-gray-200 px-4 py-2 text-sm font-medium text-gray-700 cursor-pointer " \
      "transition-colors #{EVENT_CATEGORY_TOGGLE_CLASSES.fetch(value)}" do
      concat form.radio_button(:category, value, class: "sr-only")
      concat EVENT_CATEGORY_LABELS.fetch(value)
    end
  end

  def toggled_categories(active_categories, category)
    active_categories.include?(category) ? active_categories - [ category ] : active_categories + [ category ]
  end

  def category_filter_pill(active_categories, category, label, path_params)
    active = active_categories.include?(category)
    classes = if !active
      "bg-white text-gray-500 border border-gray-200"
    elsif category == "race"
      "bg-green-600 text-white"
    else
      "bg-orange-500 text-white"
    end

    link_to label, calendar_path(**path_params, categories: toggled_categories(active_categories, category)),
      class: "rounded-xl px-4 py-2 text-sm font-semibold #{classes}"
  end

  def event_category_badge(event)
    content_tag :span, EVENT_CATEGORY_LABELS.fetch(event.category.to_sym), class:
      "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium #{EVENT_CATEGORY_BADGE_CLASSES.fetch(event.category.to_sym)}"
  end

  def event_calendar_tag(event)
    letter = event.race? ? "R" : "C"
    classes = event.race? ? "bg-green-50 text-green-700" : "bg-orange-50 text-orange-700"
    badge_classes = event.race? ? "bg-green-600" : "bg-orange-500"

    content_tag :div, class: "flex items-center gap-1 rounded px-1.5 py-1 text-xs #{classes}" do
      concat content_tag(:span, letter, class:
        "flex h-4 w-4 shrink-0 items-center justify-center rounded-full text-[10px] font-bold text-white #{badge_classes}")
      concat content_tag(:span, event.name, class: "truncate")
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

  THAI_MONTHS = %w[
    มกราคม กุมภาพันธ์ มีนาคม เมษายน พฤษภาคม มิถุนายน
    กรกฎาคม สิงหาคม กันยายน ตุลาคม พฤศจิกายน ธันวาคม
  ].freeze

  def thai_month_label(date)
    "#{THAI_MONTHS[date.month - 1]} #{date.year}"
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
