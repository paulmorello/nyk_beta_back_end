class AddVisitCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :visit_count, :integer
  end
end
