class AddTrialColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :trial, :boolean, :null => false, :default => false
  end
end
