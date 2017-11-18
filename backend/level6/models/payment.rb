require_relative 'concerns/payments/adjuster'
require_relative 'concerns/payments/processor'
require_relative 'pretty/payment'

class Payment
  include PrettyPayment
  include PaymentAdjuster
  include PaymentProcessor

  attr_reader :amount, :actor, :rental
  ACTORS = ['driver', 'owner', 'insurance', 'assistance', 'drivy']

  def initialize(actor, rental)
    @actor = actor
    @rental = rental
  end

  def self.process(rental)
    self::ACTORS.map do |actor|
      Payment.new(actor, rental)
    end
  end

  def self.adjust(initial_payments, new_payments_values)
    new_payments_values.each_with_index.map do |payment, index|
      payment.adjust_amount(initial_payments[index].amount)
    end
  end
end