require 'date'
require 'active_support/core_ext/hash/except'

class RentalModification < Base
  def initialize(modification)
    @id     = modification['id']
    @params = modification
    @rental = Rental.find(modification['rental_id'])
    super
  end

  def process
    temporary_rental = Rental.new @rental.params.merge!(@params.except('id', 'rental_id'))
    @payments = Payment.adjust(@rental.payments, temporary_rental.payments)
    @rental.update(@params.except('id', 'rental_id'), @payments)
    self
  end

  def pretty
    {
      id: @id,
      rental_id: @rental.id,
      actions: @payments.map { |action| action.pretty }
    } 
  end
end