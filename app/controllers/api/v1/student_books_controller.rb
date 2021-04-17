class Api::V1::StudentBooksController < ApplicationController
  def create
    book = Book.find_or_create_by(book_params)
    student = Student.find(params[:student_id])
    if student.specific_books('reading').count < 5
      student_book = StudentBook.new(student_id: params[:student_id], book_id: book.id, prediction: params[:prediction],
                                     status: 'reading')
      if student_book.save
        render json: StudentBookSerializer.new(student_book), status: :created
      else
        render json: { error: 'all book information must be included' }, status: :conflict
      end
    else
      render json: { error: 'student can only have 5 active books' }, status: :conflict
    end
  end

  def update
    student_book = StudentBook.where(student_id: params[:student_id], book_id: params[:book_id]).first
    student_book.update!(student_book_params)
    render json: StudentBookSerializer.new(student_book)
  rescue StandardError
    render json: { 'error' => 'something went wrong' }, status: 404
  end

  private

  def student_book_params
    params.permit(:student_id, :book_id, :status, :review, :review_comment, :prediction)
  end

  def book_params
    params.require(:book).permit(:title, :author, :pages, :isbn, :image)
  end
end
