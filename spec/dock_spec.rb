require './lib/dock'
require './lib/renter'
require './lib/boat'

RSpec.describe do
  it 'can initialize with readable attributes' do
    dock = Dock.new("The Rowing Dock", 3)
    expect(dock).to be_a(Dock)

    expect(dock.name).to eq("The Rowing Dock")
    expect(dock.max_rental_time).to eq(3)
  end

  it 'has a rent method that puts rented boats into a rental_log' do
    dock = Dock.new("The Rowing Dock", 3)
    
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)

    sup_1 = Boat.new(:standup_paddle_board, 15)

    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    dock.rent(sup_1, eugene)

    expect(dock.rental_log).to be_a(Hash)
    expect(dock.rental_log.length).to eq(3)
  end

  it 'has a charge method' do
    dock = Dock.new("The Rowing Dock", 3)
    
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)

    sup_1 = Boat.new(:standup_paddle_board, 15)

    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    dock.rent(sup_1, eugene)

    expect(dock.rental_log).to be_a(Hash)
    expect(dock.rental_log.length).to eq(3)

    kayak_1.add_hour
    kayak_1.add_hour
    
    expect(dock.charge(kayak_1)).to eq( 
      {
        :card_number => "4242424242424242",
        :amount => 40
      })
  end

  it 'does not charge for more than the max rental time' do
    dock = Dock.new("The Rowing Dock", 3)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(sup_1, eugene)

    5.times do 
      sup_1.add_hour
    end
    
    expect(dock.charge(sup_1)).to eq(
    {
      :card_number => "1313131313131313",
      :amount => 45
    })
  end
end