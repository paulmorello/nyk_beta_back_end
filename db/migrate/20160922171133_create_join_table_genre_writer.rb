class CreateJoinTableGenreWriter < ActiveRecord::Migration[5.0]
  def change
    create_join_table :genres, :writers do |t|
      # t.index [:genre_id, :writer_id]
      # t.index [:writer_id, :genre_id]
    end
  end
end
