class Payment
  attr_reader :amount, :actor
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
    pretty
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