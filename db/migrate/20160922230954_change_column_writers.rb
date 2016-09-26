class ChangeColumnWriters < ActiveRecord::Migration[5.0]
  def change
    rename_column :writers, :website, :outlet_profile
  end
end
