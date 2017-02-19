class AddTwoFieldsToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :artist, :string
    add_column :campaigns, :promotion, :string
  end
end
