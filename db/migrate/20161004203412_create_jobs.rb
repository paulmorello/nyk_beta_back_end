class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.belongs_to :outlet, index: true, foreign_key: true
      t.belongs_to :writer, index: true, foreign_key: true
      t.string :email_work
      t.string :email_personal
      t.string :position
      t.string :outlet_profile

      t.timestamps
    end
  end
end
