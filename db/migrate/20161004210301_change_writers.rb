class ChangeWriters < ActiveRecord::Migration[5.0]
  def change
    remove_column :writers, :email_work
    remove_column :writers, :email_personal
    remove_column :writers, :position
    remove_column :writers, :outlet_profile
  end
end
