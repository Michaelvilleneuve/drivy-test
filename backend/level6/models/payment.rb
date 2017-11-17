class Payment
  attr_reader :amount, :actor, :rental
  ACTORS = ['driver', 'owner', 'insurance', 'assistance', 'drivy']

  def initialize(actor, rental)
    @actor = actor
    @rental = rental
  end

  def redeem
    if @actor === 'driver'
      debit_driver
    elsif @actor === 'owner'
      credit_owner
    else
      credit_actor
    end
    self
  end

  def pretty
    {
      who: @actor,
      type: @type,
      amount: @amount
    }
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

  def adjust_amount(amount_to_adjust_with)
    adjusted_amount = @amount - amount_to_adjust_with
    if adjusted_amount < 0
      @type = @actor == 'driver' ? 'credit' : 'debit'
      @amount = -adjusted_amount
    else
      @type = @actor == 'driver' ? 'debit' : 'credit'
      @amount = adjusted_amount
    end
    self
  end

  private

  def debit_driver
    @type = 'debit'
    @amount = @rental.price
  end

  def credit_owner
    @type = 'credit'
    @amount = @rental.commission.remaining_for_owner
  end

  def credit_actor
    @type = 'credit'
    @amount = @rental.commission.send("to_#{@actor}")
  end
end