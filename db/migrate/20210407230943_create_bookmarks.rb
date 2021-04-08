class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :student_book, null: false, foreign_key: true
      t.date :date
      t.integer :minutes
      t.integer :page_number

      t.timestamps
    end
  end
end
