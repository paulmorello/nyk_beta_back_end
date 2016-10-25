class CreateSavedJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_jobs do |t|
      t.references :campaign
      t.references :job

      t.timestamps
    end
  end
end
