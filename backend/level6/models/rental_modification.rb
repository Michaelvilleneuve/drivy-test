require 'date'
require 'active_support/core_ext/hash/except'
require_relative 'pretty/rental_modification'

class RentalModification < Base
  include PrettyRentalModification

  def initialize(modification)
    @id     = modification['id']
    @params = modification
    @rental = Rental.find(modification['rental_id'])
    super
  end

  def process
    temporary_rental = TemporaryRental.new @rental.params.merge(@params.except('id', 'rental_id'))
    @payments = Payment.adjust(@rental.payments, temporary_rental.payments)
    @rental.update(@params.except('id', 'rental_id'), @payments)
    temporary_rental.destroy
    self
  end
end