class CalendarController < ApplicationController
  CATEGORIES = %w[race camp].freeze

  def index
    @year = parse_year(params[:year]) || Date.current.year
    @active_categories = (params[:categories].presence || CATEGORIES) & CATEGORIES

    events = Event.in_year(@year).where(category: @active_categories).order(:start_date)
    @events_by_month = events.group_by { |event| event.start_date.month }
  end

  private

  def parse_year(value)
    Integer(value) if value.present?
  rescue ArgumentError
    nil
  end
end
