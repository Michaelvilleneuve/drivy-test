Dir["./models/*.rb"].each { |file| require file }

describe Commission do
  before do
    @car = Car.new({'id' => 1, 'price_per_day' => 100, 'price_per_km' => 1 })
    @rental = Rental.new({ 
      'id' => 1, 
      'car_id' => 1, 
      'start_date' => '2017-12-10', 
      'end_date' => '2017-12-10',
      'distance' => 100 
    })
    @commission = @rental.commission

    @expected = { total: 60, insurance: 30, assistance: 1, drivy: 29 }
  end

  it "should compute total commission price" do
    expect(@commission.total).to eq(@expected[:total])
  end

  it "should assign half of the commission to the insurance" do
    expect(@commission.to_insurance).to eq(@expected[:insurance])
  end

  it "should assign 1€ per day to to_roadside_assistance" do
    expect(@commission.to_roadside_assistance).to eq(@expected[:assistance])
  end

  it "should assign what is left to Drivy" do
    expect(@commission.to_drivy).to eq(@expected[:drivy])
  end
end