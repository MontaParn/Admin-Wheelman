class Podium
  def self.by_tenure(limit: 10)
    Athlete.active.order(:started_on).limit(limit)
  end

  def self.by_punctuality(limit: 10)
    Athlete.active
      .select { |athlete| athlete.payments.paid.exists? }
      .sort_by { |athlete| -athlete.on_time_payment_rate }
      .first(limit)
  end

  def self.by_race_count(limit: 10)
    Athlete.active
      .sort_by { |athlete| -athlete.race_count_this_year }
      .first(limit)
  end
end
