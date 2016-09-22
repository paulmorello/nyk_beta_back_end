class ChangeCountriesColumnWriters < ActiveRecord::Migration[5.0]
  def change
    remove_column :writers, :country
    add_reference :writers, :country, foreign_key: true
  end
end
