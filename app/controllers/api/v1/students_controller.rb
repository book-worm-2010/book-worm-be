class Api::V1::StudentsController < ApplicationController
  def books
    student = Student.find(params[:id])
    books = student.books.where('student_books.status = ?', params[:status])
    render json: BookSerializer.new(books.paginate(params[:per_page], params[:page]))
  end

  def bookmarks
    student = Student.find(params[:id])
    bookmarks = student.student_books.map do |student_book|
      student_book.bookmarks
    end.flatten
    render json: BookmarkSerializer.new(bookmarks)
  end
end
