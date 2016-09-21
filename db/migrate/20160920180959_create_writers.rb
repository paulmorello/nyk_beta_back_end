class CreateWriters < ActiveRecord::Migration[5.0]
  def change
    create_table :writers do |t|
      ## General Info
      t.string :f_name, null: false
      t.string :l_name, null: false
      t.string :position
      t.string :website
      t.string :email_work, null: false
      t.string :email_personal
      t.string :city
      t.string :state
      t.string :country
      ## Social Info
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :linkedin
      ## Extra Buckets
      t.boolean :key_contact, default: false
      t.boolean :freelance, default: false
      t.boolean :flagged, default: false
      t.boolean :inactive, default: false

      t.timestamps
    end
  end
end
