class AddFollowUpFieldToSavedJob < ActiveRecord::Migration[5.0]
  def change
    add_column :saved_jobs, :followed_up, :string
  end
end
