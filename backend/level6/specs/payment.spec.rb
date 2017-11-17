Dir["./models/*.rb"].each { |file| require file }

describe Payment do
  before do
    Car.new({ 'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10 })
    @rental = Rental.new({ 
      'id' => 1, 
      'car_id' => 1, 
      'start_date' => '2017-12-8', 
      'end_date' => '2017-12-9',
      'distance' => 100 
    })
    @payments = @rental.payments.each { |payment| payment.redeem }
  end

  it "should process every actors" do
    @payments.each do |payment|
      expect(payment.amount).not_to be nil
    end
  end

  it "should debit the whole rental amount to the driver" do
    @driver_payment = @payments.find { |payment| payment.actor == 'driver' }
    expect(@driver_payment.amount).to eq @rental.price
  end

  it "should credit the insurance's commission to the insurance" do
    @insurance_payment = @payments.find { |payment| payment.actor == 'insurance' }
    expect(@insurance_payment.amount).to eq @rental.commission.to_insurance
  end

  it "should credit the drivy's commission to drivy" do
    @drivy_payment = @payments.find { |payment| payment.actor == 'drivy' }
    expect(@drivy_payment.amount).to eq @rental.commission.to_drivy
  end

  it "should credit the assistance's commission to the assistance" do
    @assistance_payment = @payments.find { |payment| payment.actor == 'assistance' }
    expect(@assistance_payment.amount).to eq @rental.commission.to_assistance
  end
end