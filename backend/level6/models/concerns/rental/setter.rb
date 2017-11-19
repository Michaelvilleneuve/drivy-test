module RentalValuesSetter
  def set_values(rental)
    @params     = rental
    @distance   = rental.fetch('distance', @distance)
    @deductible = rental.fetch('deductible_reduction', @deductible)
    @end_date   = Date.parse(rental['end_date']) if rental['end_date']
    @start_date = Date.parse(rental['start_date']) if rental['start_date']
    @commission = Commission.new(self)
  end
end