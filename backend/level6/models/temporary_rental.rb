require_relative 'rental'

class TemporaryRental < Rental
  def destroy
    super
  end
end