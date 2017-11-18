module PrettyRentalModification
  def pretty
    {
      id: @id,
      rental_id: @rental.id,
      actions: @payments.map { |action| action.pretty }
    } 
  end
end