class Dock
  attr_reader :name,
              :max_rental_time,
              :rental_log,
              :charge_log
  
  
  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @charge_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    @charge_log[:card_number] = @rental_log[boat].credit_card_number
    @charge_log[:amount] = boat.price_per_hour * 
      if boat.hours_rented < @max_rental_time
        boat.hours_rented
      else
        @max_rental_time
      end
    @charge_log
  end
end