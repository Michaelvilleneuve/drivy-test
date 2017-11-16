class Base
  @@list = []
  
  def initialize(object)
    @@list << self
  end

  protected

  def self.all_cars
    @@list.select { |object| object.is_a? Car }
  end

  def self.all_rentals
    @@list.select { |object| object.is_a? Rental }
  end
end