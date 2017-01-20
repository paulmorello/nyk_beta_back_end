class AddOutletdescriptionColumn < ActiveRecord::Migration[5.0]
  def change

    add_column :outlets, :description, :string
  end
end
