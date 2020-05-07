DRIVERS = [
  {
  id: 1,
  name: "Bernardo Prosacco",
  vin: "WBWSS52P9NEYLVDE9",
  available: true,
  },
  {
    id: 2,
    name: "Emory Rosenbaum",
    vin: "1B9WEX2R92R12900E",
    available: true,
  },

]

class DriversController < ApplicationController
  def index
    @drivers = DRIVERS
  end

  def new
  end

  def create
  end

  def show
    driver_id = params[:id].to_i
    @driver = DRIVERS[driver_id]

    if @driver.nil?
      head :not_found
      return
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
