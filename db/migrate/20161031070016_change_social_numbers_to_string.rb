class ChangeSocialNumbersToString < ActiveRecord::Migration[5.0]
  def change
    change_column :outlets, :twitter_followers,  :string
    change_column :outlets, :facebook_likes,  :string
    change_column :outlets, :instagram_followers,  :string

    add_column :writers, :twitter_followers,  :string

  end
end
