module RentalValuesSetter
  def set_values(rental)
    @params     = rental
    @distance   = rental['distance'] if rental['distance']
    @deductible = rental['deductible_reduction'] if rental['deductible_reduction']
    @end_date   = Date.parse(rental['end_date']) if rental['end_date']
    @start_date = Date.parse(rental['start_date']) if rental['start_date']
    @commission = Commission.new(self)
  end
end