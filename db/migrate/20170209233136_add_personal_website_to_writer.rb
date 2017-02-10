class AddPersonalWebsiteToWriter < ActiveRecord::Migration[5.0]
  def change
    add_column :writers, :personal_website, :string
  end
end
