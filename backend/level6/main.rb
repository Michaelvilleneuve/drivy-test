Dir["./models/*.rb"].each { |file| require file }
require 'json'
require 'json/ext'

class Main
  def initialize input
    data = JSON.parse(File.read(input))
    @cars = data['cars'].map { |car| Car.new(car) }
    @rentals = data['rentals'].map { |rental| Rental.new(rental) }
    @modifications = data['rental_modifications'].map { |mod| RentalModification.new(mod).process }
  end

  def generate_output
    File.write('output.json', JSON.pretty_generate({ rental_modifications: @modifications.map(&:pretty) }))
  end
end

drivy = Main.new('data.json')
drivy.generate_output