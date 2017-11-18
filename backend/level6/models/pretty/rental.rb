module PrettyRental
  def pretty
    { id: @id, actions: @payments }
  end
end