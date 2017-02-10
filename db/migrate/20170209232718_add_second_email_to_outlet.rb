class AddSecondEmailToOutlet < ActiveRecord::Migration[5.0]
  def change
    add_column :outlets, :second_email, :string
  end
end
