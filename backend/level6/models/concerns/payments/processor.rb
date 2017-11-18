module PaymentProcessor
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