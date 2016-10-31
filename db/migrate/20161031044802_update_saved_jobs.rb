class UpdateSavedJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :saved_jobs, :response, :string
    add_column :saved_jobs, :response_updated_at, :datetime
  end
end
