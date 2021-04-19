class AddFieldsToBookmarks < ActiveRecord::Migration[6.1]
  def change
    add_column :bookmarks, :notes, :string
    add_column :bookmarks, :reactions, :string
  end
end
