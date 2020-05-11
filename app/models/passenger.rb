class Passenger < ApplicationRecord
  has_many :trips
  validates :name ,presence: true 
  validates :phone_num ,presence: true 

  def total_charged
    total = 0 
    self.trips.each do |trip|
      total += trip.cost 
    end  
    return "$#{ '%.2f' % total}"
  end 

  def add_trip

    @new_trip = Trip.new
    @new_trip.passenger = self
    @new_trip.date = DateTime.now
    @new_trip.cost = rand() * 100 
    @new_trip.assign_driver
    @new_trip.save

    Trip.last.driver.update(available:false)
    
  end 
end
