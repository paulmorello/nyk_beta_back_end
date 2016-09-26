class ChangeUniqunessOutletsWriters < ActiveRecord::Migration[5.0]
  def change
    add_index :outlets, :name, :unique => true
    add_index :writers, :email_work, :unique => true
  end
end
