class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  def assign_driver
    first_available_driver = Driver.find_by(available:true)
    self.driver =  first_available_driver
  end 

end
