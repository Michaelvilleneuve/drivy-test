Dir["./models/*.rb"].each { |file| require file }

describe Rental do
  before do
    @car = Car.new({'id' => 1, 'price_per_day' => 100, 'price_per_km' => 10 })
  end

  it "should raise proper error if keys are missing" do
    expect { Car.new({'id' => 1}) }.to raise_error KeyError
  end

  it "should decrease price per day by 10% after 1 day" do
    expect(@car.price_on_day(2)).to eq 90
  end

  it "should decrease price per day by 30% after 4 day" do
    expect(@car.price_on_day(5)).to eq 70
  end

  it "should decrease price per day by 50% after 10 day" do
    expect(@car.price_on_day(11)).to eq 50
  end

  it "should return normal price otherwise" do
    expect(@car.price_on_day(1)).to eq 100
  end
end