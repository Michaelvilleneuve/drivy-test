module PaymentAdjuster
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
end