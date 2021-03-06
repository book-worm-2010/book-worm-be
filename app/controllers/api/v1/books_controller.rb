class Api::V1::BooksController < ApplicationController
  def index
    if params[:title].present? && params[:author].present?
      books = BookFacade.book_info(book_params)
      render json: BookSerializer.new(books)
    else
      render json: { error: 'must include both title and author' }, status: :bad_request
    end
  end

  def show
    if Book.exists?(params[:id])
      render json: BookSerializer.new(Book.find(params[:id]))
    else
      render json: { error: "No book id #{params[:id]}" }, status: :not_found
    end
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: BookSerializer.new(book), status: :created
    else
      render json: { data: book.errors }, status: :conflict
    end
  end

  def update
    book = Book.find(params[:title])
    if book.update(book_params)
      render json: BookSerializer.new(book), status: :accepted
    else
      render json: { data: book.errors }, status: :not_found
    end
  end

  def destroy
    render json: Book.destroy(params[:id])
  end

  def find_all
    if params[:title].present?
      render json: BookSerializer.new(Book.search(params[:title]))
    else
      render json: { data: [] }, status: :bad_request
    end
  end

  private

  def book_params
    params.permit(:title, :author)
  end
end
