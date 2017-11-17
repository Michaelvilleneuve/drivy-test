module Prices
  def price
    (price_without_deductible + deductible_cost).to_i
  end

  def price_without_deductible
    price_of_days + price_of_kms
  end

  def deductible_cost
    @deductible ? (nb_of_days * Rental::DEDUCTIBLE_COST_PER_DAY) : 0
  end

  def price_of_days
    total_days_price = 0
    nb_of_days.times do |day_number|
      total_days_price += @car.price_on_day(day_number + 1)
    end
    total_days_price
  end

  def price_of_kms
    @car.price_per_km * @distance
  end
end
