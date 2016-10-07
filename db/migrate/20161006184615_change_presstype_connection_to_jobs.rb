class ChangePresstypeConnectionToJobs < ActiveRecord::Migration[5.0]
  def change
    remove_reference :presstype_tags, :writer, foreign_key: true
    add_reference :presstype_tags, :job, foreign_key: true
  end
end
