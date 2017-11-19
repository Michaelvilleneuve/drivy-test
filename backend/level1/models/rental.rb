require 'date'

class Rental < Base

  def initialize(rental)
    @id         = rental.fetch('id')
    @start_date = Date.parse(rental.fetch('start_date'))
    @end_date   = Date.parse(rental.fetch('end_date'))
    @distance   = rental.fetch('distance')
    @car = Car.find(rental.fetch('car_id'))
    super
  end

  def price
    (price_of_days + price_of_kms).to_i
  end

  def pretty
    { id: @id, price: price }
  end

  def nb_of_days
    (@end_date - @start_date).to_i + 1
  end

  def price_of_days
    nb_of_days * @car.price_per_day
  end

  def price_of_kms
    @car.price_per_km * @distance
  end
end