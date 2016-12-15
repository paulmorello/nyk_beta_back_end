class CreateCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :counters do |t|
      t.string :name
      t.integer :count
    end
  end
end
