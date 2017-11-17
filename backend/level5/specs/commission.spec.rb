Dir["./models/*.rb"].each { |file| require file }
require 'json/ext'

describe Commission do
  before do
    @car = Car.new({ 'id' => 987, 'price_per_day' => 2000, 'price_per_km' => 10 })
    @rental = Rental.new({ 
      'id' => 1, 
      'car_id' => 987, 
      'start_date' => '2017-12-10', 
      'end_date' => '2017-12-10',
      'distance' => 100,
      'deductible_reduction' => false
    })
    @commission = @rental.commission

    @expected = { insurance_fee: 450, assistance_fee: 100, drivy_fee: 350 }
  end

  it "should compute total commission price" do
    expect(@commission.total).to eq(900)
  end

  it "should assign half of the commission to the insurance" do
    expect(@commission.to_insurance).to eq(@expected[:insurance_fee])
  end

  it "should assign 1€ per day to to_assistance" do
    expect(@commission.to_assistance).to eq(@expected[:assistance_fee])
  end

  it "should assign what is left to Drivy" do
    expect(@commission.to_drivy).to eq(@expected[:drivy_fee])
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
    expect(@rental.commission.to_drivy).to eq(@expected[:drivy_fee] + 400)
  end

  it "outputs the correct format" do
    expect(@commission.pretty).to eq @expected
  end
end