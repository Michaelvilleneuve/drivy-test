require 'date'
require_relative 'pretty/rental'
require_relative 'concerns/rental/days'
require_relative 'concerns/rental/prices'
require_relative 'concerns/rental/setter'

class Rental < Base
  include Days
  include Prices
  include PrettyRental
  include RentalValuesSetter

  attr_reader :commission, :payments, :id, :params, :start_date

  DEDUCTIBLE_COST_PER_DAY = 400

  def initialize(rental)
    @id = rental['id']
    @car = Car.find rental['car_id']
    set_values rental
    @payments = Payment.process(self).map { |payment| payment.redeem }
    super
  end

  def update(rental, payments)
    set_values rental
    @payments = @payments + payments
  end

  def self.find(a_rental_id)
    self.all(Rental).find { |rental| rental.id == a_rental_id }
  end

  def destroy
    super
  end
end