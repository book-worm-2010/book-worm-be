class Api::V1::StudentBooksController < ApplicationController
  def create
    # require 'pry'; binding.pry
    book = Book.find_or_create_by(book_params)
    student_book = StudentBook.new(student_id: params[:student_id], book_id: book.id, prediction: params[:prediction])
    if student_book.save
      render json: StudentBookSerializer.new(student_book), status: :created
    else
      render json: { data: {} }, status: :conflict
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
    params.permit(:student_id, :book_id, :status, :review, :review_comment, :prediction)
  end

  def book_params
    params.require(:book).permit(:title, :author, :pages, :isbn, :image)
  end
end
