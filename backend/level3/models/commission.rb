class Commission < Base
  attr_reader :total
  RATE_PERCENTAGE = 0.7

  def initialize(rental)
    @rental = rental
    @total = rental.price - (rental.price * Commission::RATE_PERCENTAGE)
  end

  def to_insurance
    @total / 2
  end

  def to_roadside_assistance
    @rental.nb_of_days
  end

  def to_drivy
    @total - to_insurance - to_roadside_assistance
  end
end