class AddThirdEmailToOutlet < ActiveRecord::Migration[5.0]
  def change
    add_column :outlets, :third_email, :string
  end
end
