class MoveKeyContactToJob < ActiveRecord::Migration[5.0]
  def change
    remove_column :writers, :key_contact
    add_column :jobs, :key_contact, :boolean
  end
end
