class TripsController < ApplicationController
  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def new 
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new
      @trip.assign_driver
      @trip.date = DateTime.now
      @trip.cost = rand() * 100 
      @trip.save
      
      Trip.last.driver.update(available:false)
      redirect_to passenger_path(@trip.passenger_id)
    else 
      head :not_found
    end 
  end 

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id)
      return
    else
      render :edit
      return
    end  
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    else
      @trip.destroy
      redirect_to passengers_path
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end
