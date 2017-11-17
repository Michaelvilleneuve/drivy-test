class Car < Base
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(car)
    @id = car['id']
    @price_per_day = car['price_per_day']
    @price_per_km = car['price_per_km']
    super
  end

  def self.find(a_car_id)
    self.all(Car).find { |car| car.id == a_car_id }
  end
end