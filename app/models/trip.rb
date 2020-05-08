class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  # def new_trip_driver
  #   first_available_driver = Driver.find_by(available:true)
  #   new_trip = Trip.new
  #   self.driver = first_available_driver
  # end 

end
