class RemoveVisitCountFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :visit_count, :string
  end
end
