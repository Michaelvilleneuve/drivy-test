class Car < Base
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(car)
    @id = car.fetch('id')
    @price_per_day = car.fetch('price_per_day')
    @price_per_km = car.fetch('price_per_km')
    super
  end

  def self.find(a_car_id)
    self.all(Car).find { |car| car.id == a_car_id }
  end
end