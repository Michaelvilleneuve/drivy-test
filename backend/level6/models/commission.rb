class Commission < Base
  attr_reader :total
  RATE_PERCENTAGE = 0.7

  def initialize(rental)
    @rental = rental
    @total = rental.price_without_deductible - (rental.price_without_deductible * Commission::RATE_PERCENTAGE)
  end

  def to_insurance
    (@total / 2).to_i
  end

  def to_assistance
    @rental.nb_of_days * 100
  end

  def to_drivy
    ((@total - to_insurance - to_assistance) + @rental.deductible_cost).to_i
  end

  def remaining_for_owner
    (@rental.price_without_deductible - @total).to_i
  end

  def pretty
    {
      insurance_fee: to_insurance,
      assistance_fee: to_assistance,
      drivy_fee: to_drivy
    }
  end
end