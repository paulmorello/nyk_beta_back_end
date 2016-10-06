class CreateOutlets < ActiveRecord::Migration[5.0]
  def change
    create_table :outlets do |t|
      ## Genral Info
      t.string :name, null: false
      t.string :website
      t.string :email
      t.string :city
      t.string :state
      t.references :country
      ## Social Info
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :linkedin
      t.integer :twitter_followers
      t.integer :facebook_likes
      t.integer :instagram_followers
      t.boolean :hype_m, default: false
      t.boolean :submithub, default: false
      ## Extra Buckets
      t.boolean :flagged, default: false
      t.boolean :inactive, default: false
      t.string :notes

      t.timestamps
    end
  end
end
