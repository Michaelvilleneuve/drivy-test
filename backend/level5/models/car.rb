class Car < Base
  attr_reader :id, :price_per_km

  def initialize(car)
    @id = car['id']
    @price_per_day = car['price_per_day']
    @price_per_km = car['price_per_km']
    super
  end

  def price_on_day(day_number)
    return @price_per_day * 0.9 if day_number > 1 && day_number <= 4
    return @price_per_day * 0.7 if day_number > 4 && day_number <= 10
    return @price_per_day * 0.5 if day_number > 10
    return @price_per_day
  end


  def self.find(a_car_id)
    self.all(Car).find { |car| car.id == a_car_id }
  end
end