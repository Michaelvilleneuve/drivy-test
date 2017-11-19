require 'date'

class Rental < Base
  attr_reader :commission

  def initialize(rental)
    @id         = rental.fetch('id')
    @start_date = Date.parse(rental.fetch('start_date'))
    @end_date   = Date.parse(rental.fetch('end_date'))
    @distance   = rental.fetch('distance')
    @car = Car.find(rental.fetch('car_id'))
    @commission = Commission.new(self)
    super
  end

  def price
    (price_of_days + price_of_kms).to_i
  end

  def pretty
    { 
      id: @id, 
      price: price,
      commission: @commission.pretty
    }
  end

  def nb_of_days
    (@end_date - @start_date).to_i + 1
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