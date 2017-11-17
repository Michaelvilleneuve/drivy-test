require_relative 'concerns/rental/days'
require_relative 'concerns/rental/prices'
require 'date'

class Rental < Base
  include Days
  include Prices

  attr_reader :commission, :payments, :id, :params, :start_date

  DEDUCTIBLE_COST_PER_DAY = 400

  def initialize(rental)
    @id = rental['id']
    @car = Car.find rental['car_id']
    set_values rental
    @payments = Payment.process(self).map { |payment| payment.redeem }
    super
  end

  def set_values(rental)
    @params     = rental
    @distance   = rental['distance'] if rental['distance']
    @deductible = rental['deductible_reduction'] if rental['deductible_reduction']
    @end_date   = Date.parse(rental['end_date']) if rental['end_date']
    @start_date = Date.parse(rental['start_date']) if rental['start_date']
    @commission = Commission.new self
  end

  def update(rental, payments)
    set_values rental
    @payments = payments
  end

  def pretty
    { id: @id, actions: @payments }
  end

  def self.find(a_rental_id)
    self.all(Rental).find { |rental| rental.id == a_rental_id }
  end
end