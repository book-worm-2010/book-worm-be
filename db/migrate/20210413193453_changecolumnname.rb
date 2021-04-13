class Changecolumnname < ActiveRecord::Migration[6.1]
  def change
    rename_column :student_books, :reivew_comment, :review_comment
  end
end
