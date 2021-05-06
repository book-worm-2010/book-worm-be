class Api::V1::StudentsController < ApplicationController
  def login
    student = Student.find_or_create_by(student_params)
    if student.save
      render json: StudentSerializer.new(student)
    else
      render json: { error: 'please include both email and name' }, status: :conflict
    end
  end

  def books
    student = Student.find(params[:id])
    student_books = if params[:status]
                      student.specific_books(params[:status])
                    else
                      student.student_books
                    end
    render json: StudentBookSerializer.new(student_books,
                                           include: [:book])
  end

  def bookmarks
    student_books = StudentBook.where(student_id: params[:student_id], book_id: params[:book_id])
    bookmarks = student_books.map do |student_book|
      student_book.bookmarks
    end.flatten
    render json: BookmarkSerializer.new(bookmarks)
  end

  private

  def student_params
    params.permit(:name, :email)
  end
end
