require 'date'

class Rental < Base

  def initialize(rental)
    @id         = rental['id']
    @start_date = rental['start_date']
    @end_date   = rental['end_date']
    @distance   = rental['distance']
    @car = Car.find rental['car_id']
    super
  end

  def price
    price_of_days + price_of_kms
  end

  def pretty
    { id: @id, price: price }
  end

  def nb_of_days
    (Date.parse(@end_date).to_time.to_i - Date.parse(@start_date).to_time.to_i) / 86400
  end

  def price_of_days
    nb_of_days * @car.price_per_day
  end

  def price_of_kms
    @car.price_per_km * @distance
  end
end