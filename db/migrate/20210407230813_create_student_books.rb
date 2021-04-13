class CreateStudentBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :student_books do |t|
      t.references :student, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :status
      t.integer :review
      t.string :reivew_comment

      t.timestamps
    end
  end
end
