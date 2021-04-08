class Api::V1::StudentBooksController < ApplicationController
  def create
    student_book = StudentBook.new(student_book_params)
    if student_book.save
      render json: StudentBookSerializer.new(student_book), status: :created
    else
      render json: { data: book.errors }, status: :conflict
    end
  end

  private

  def student_book_params
    params.permit(:student_id, :book_id)
  end
end
