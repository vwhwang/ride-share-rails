class AddTripsToPassenger < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :passenger, index: true 
  end
end
