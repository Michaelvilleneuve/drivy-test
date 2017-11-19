module PrettyRentalModification
  def pretty
    {
      id: @id,
      rental_id: @rental.id,
      actions: @payments.map(&:pretty)
    } 
  end
end