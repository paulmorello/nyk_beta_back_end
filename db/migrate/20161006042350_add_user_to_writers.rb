class AddUserToWriters < ActiveRecord::Migration[5.0]
  def change
    add_reference :writers, :user, foreign_key: true
  end
end
