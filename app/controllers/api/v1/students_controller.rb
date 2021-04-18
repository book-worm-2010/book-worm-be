class Api::V1::StudentsController < ApplicationController
  def books
    student = Student.find(params[:id])
    books = if params[:status]
              student.specific_books(params[:status])
            else
              student.books
            end
    render json: BookSerializer.new(books.paginate(params[:per_page], params[:page]))
  end

  def bookmarks
    student_books = StudentBook.where(student_id: params[:student_id], book_id: params[:book_id])
    bookmarks = student_books.map do |student_book|
      student_book.bookmarks
    end.flatten
    render json: BookmarkSerializer.new(bookmarks)
  end
end
