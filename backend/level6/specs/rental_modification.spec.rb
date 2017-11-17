Dir["./models/*.rb"].each { |file| require file }

describe RentalModification do
  before do
    Base.delete_all
    @car = Car.new({'id' => 321, 'price_per_day' => 1000, 'price_per_km' => 10 })
    @rental = Rental.new({ 
      'id' => 321, 
      'car_id' => 321, 
      'start_date' => '2017-12-7', 
      'end_date' => '2017-12-8',
      'distance' => 100 
    })
  end

  it "should update rental price according to new values" do
    @rental_modification = RentalModification.new({ 'id' => 123, 'rental_id' => 321, 'start_date' => '2017-12-6' })
    @same_rental = Rental.new({ 
      'id' => 322, 
      'car_id' => 321, 
      'start_date' => '2017-12-7', 
      'end_date' => '2017-12-8',
      'distance' => 100 
    })
    expect(@same_rental.price === @rental.price).to be true
    @rental_modification.process
    expect(@same_rental.price < @rental.price).to be true
  end

  it "pretty prints the modifications" do
    @rental_modification = RentalModification.new({ 'id' => 124, 'rental_id' => 321, 'start_date' => '2017-12-6' })
    @rental_modification.process

    expect(@rental_modification.pretty[:id]).to be 124
    expect(@rental_modification.pretty[:rental_id]).to be 321
    expect(@rental_modification.pretty[:actions].map{ |a| a[:who] } == Payment::ACTORS).to be true
  end
end