class ChangeTripRatingToInteger < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :rating, :integer
  end
end
