class SetDefaultValueOfAvailableToTrue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :drivers, :available, true
  end
end
