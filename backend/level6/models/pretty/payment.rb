module PrettyPayment
  def pretty
    {
      who: @actor,
      type: @type,
      amount: @amount
    }
  end
end