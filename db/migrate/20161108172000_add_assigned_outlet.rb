class AddAssignedOutlet < ActiveRecord::Migration[5.0]
  def change
    add_reference :outlets, :user, foreign_key: true
  end
end
