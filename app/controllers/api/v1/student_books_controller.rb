class Api::V1::StudentBooksController < ApplicationController
  def create
    student_book = StudentBook.new(student_book_params)
    if student_book.save
      render json: StudentBookSerializer.new(student_book), status: :created
    else
      render json: { data: book.errors }, status: :conflict
    end
  end

  def update
    student_book = StudentBook.find(params[:id])
    student_book.update!(student_book_params)
    render json: StudentBookSerializer.new(student_book)
  rescue StandardError
      render json: { 'error' => {} }, status: 404
  end

  private

  def student_book_params
    params.permit(:student_id, :book_id, :status, :review, :reivew_comment)
  end
end
