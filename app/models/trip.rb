class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver
  validates :date, presence: true
  validates :cost, presence: true
  # validates :rating, inclusion: { :in => 1..5 }

  def assign_driver
    puts "assign driver"
    first_available_driver = Driver.find_by(available:true)
    self.driver =  first_available_driver
  end 

end
