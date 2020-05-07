PASSENGERS = [{
  id: 1,
  name: "vicki",
  phone_num: "206-333-4444"
},
{
  id: 2,
  name: "andrew",
  phone_num: "206-333-4444"
},
]

class PassengersController < ApplicationController

  def index
    @passengers = PASSENGERS
  end 

  def show 
    passenger_id = params[:id].to_i
    @passenger = PASSENGERS[passenger_id]

    if @passenger.nil? 
      head :not_found 
      return
    end 
  end 

  

end
