class CreateJoinTableOutletWriter < ActiveRecord::Migration[5.0]
  def change
    create_join_table :outlets, :writers do |t|
      # t.index [:outlet_id, :writer_id]
      # t.index [:writer_id, :outlet_id]
    end
  end
end
