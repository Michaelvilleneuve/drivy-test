Dir["./models/*.rb"].each { |file| require file }
require 'json/ext'

describe Commission do
  before do
    @car = Car.new({'id' => 987, 'price_per_day' => 100, 'price_per_km' => 1 })
    @rental = Rental.new({ 
      'id' => 1, 
      'car_id' => 987, 
      'start_date' => '2017-12-10', 
      'end_date' => '2017-12-10',
      'distance' => 100,
      'deductible_reduction' => false
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

  it "should assign deductible cost to Drivy if any" do
    @rental = Rental.new({ 
      'id' => 1, 
      'car_id' => 987, 
      'start_date' => '2017-12-10', 
      'end_date' => '2017-12-10',
      'distance' => 100,
      'deductible_reduction' => true
    })
    expect(@rental.commission.to_drivy).to eq(@expected[:drivy] + 4)
  end

  it "outputs the correct format" do
    expect(@commission.pretty.to_json).to eq '{"insurance_fee":30.0,"assistance_fee":1,"drivy_fee":29.0}'
  end
end