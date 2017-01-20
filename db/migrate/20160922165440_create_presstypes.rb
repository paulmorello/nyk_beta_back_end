class CreatePresstypes < ActiveRecord::Migration[5.0]
  def change
    create_table :presstypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
