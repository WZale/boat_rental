require './lib/boat'

RSpec.describe do
  it 'can initialize with readable attributes' do
    kayak = Boat.new(:kayak, 20)
    expect(kayak).to be_a(Boat)

    expect(kayak.type).to eq(:kayak)
    expect(kayak.price_per_hour).to eq(20)
  end

  it 'has an hours_rented instance variable' do
    kayak = Boat.new(:kayak, 20)
    expect(kayak.hours_rented).to eq(0)
  end

  it 'has an add_hour method that increments hours_rented' do
    kayak = Boat.new(:kayak, 20)
    
    kayak.add_hour
    kayak.add_hour
    kayak.add_hour

    expect(kayak.hours_rented).to eq(3)
  end
end