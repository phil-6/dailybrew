class ChangeBrewWeightsToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :brews, :water_weight, :decimal, precision: 5, scale: 1
    change_column :brews, :coffee_weight, :decimal, precision: 5, scale: 2
  end
end
