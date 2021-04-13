class AddPredictionToStudentBook < ActiveRecord::Migration[6.1]
  def change
    add_column :student_books, :prediction, :string
  end
end
