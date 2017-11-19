Dir["./models/*.rb"].each { |file| require file }

describe Rental do
  before do
    @car = Car.new({'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 })
    @rental = Rental.new({ 
      'id' => 1, 
      'car_id' => 1, 
      'start_date' => '2017-12-8', 
      'end_date' => '2017-12-9',
      'distance' => 100 
    })
  end

  it "should raise proper error if keys are missing" do
    expect { Rental.new({'distance': 100}) }.to raise_error KeyError
  end

  it "should have a duration in days" do
    expect(@rental.nb_of_days).to eq 2
  end

  it "should calculate the car's price per day" do
    expect(@rental.price_of_days).to eq 3800
  end

  it "should calculate the car's price per km" do
    expect(@rental.price_of_kms).to eq 1000 
  end

  it "should sum price per day and price per km" do
    expect(@rental.price).to eq 4800 
  end

  it "should have a commission attribute" do
    expect(@rental.commission).not_to be nil
  end
end