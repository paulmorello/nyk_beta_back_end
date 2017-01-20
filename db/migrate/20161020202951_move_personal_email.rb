class MovePersonalEmail < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :email_personal
    add_column :writers, :email_personal, :string
  end
end
