class ChangeCountriesColumnOutlets < ActiveRecord::Migration[5.0]
  def change
    remove_column :outlets, :country
    add_reference :outlets, :country, foreign_key: true
  end
end
