class AddStafflistToOutlets < ActiveRecord::Migration[5.0]
  def change
    add_column :outlets, :staff_list, :string
  end
end
