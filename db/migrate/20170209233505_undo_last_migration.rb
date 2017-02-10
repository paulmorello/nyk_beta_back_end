class UndoLastMigration < ActiveRecord::Migration[5.0]
  def change
    remove_column :writers, :secondary_email_work, :string
    add_column :jobs, :secondary_email_work, :string
  end
end
