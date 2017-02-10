class AddSecondWorkEmailToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :writers, :secondary_email_work, :string
  end
end
