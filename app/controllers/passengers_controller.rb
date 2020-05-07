
class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all.order(:id)
  end 

  def show 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil? 
      head :not_found 
      return
    end 
  end 

  def new 
    @passenger = Passenger.new
  end 

end
