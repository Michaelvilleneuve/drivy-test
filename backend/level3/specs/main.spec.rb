require './main.rb'

describe Main do
  before do
    File.delete('./output.json')
    drivy = Main.new 'data.json'
    drivy.generate_output
  end


  it "should create an output file" do
    expect(File.exists?('./output.json')).to be true
  end

  it "should write a valid json file" do
    expect(JSON.parse(File.read('./output.json')).class).to eq Hash
  end

  it "writes a rental list" do
    expect(JSON.parse(File.read('./output.json'))['rentals'].length).to eq 3
  end
end