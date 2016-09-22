class CreateJoinTablePresstypeWriter < ActiveRecord::Migration[5.0]
  def change
    create_join_table :presstypes, :writers do |t|
      # t.index [:presstype_id, :writer_id]
      # t.index [:writer_id, :presstype_id]
    end
  end
end
