class AddTemperatureToBrews < ActiveRecord::Migration[7.0]
  def change
    add_column :brews, :temperature, :decimal, precision: 5, scale: 2
  end
end
