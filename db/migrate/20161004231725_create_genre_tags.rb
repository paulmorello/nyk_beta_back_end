class CreateGenreTags < ActiveRecord::Migration[5.0]
  def change
    create_table :genre_tags do |t|

      t.belongs_to :writer, index: true, foreign_key: true
      t.belongs_to :genre, index: true, foreign_key: true

      t.timestamps
    end
  end
end
