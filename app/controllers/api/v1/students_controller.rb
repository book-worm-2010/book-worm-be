class Api::V1::StudentsController < ApplicationController
  def show
    authenticate_request
  end

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

  private

  def authenticate_request!
    if valid_token?
      @current_user = User.find(auth_token[:user_id])
    else
      render json: {}, status: :unauthorized
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {}, status: :unauthorized
  end

  def valid_token?
    request.headers['Authorization'].present? && auth_token.present?
  end

  def auth_token
    @auth_token ||= JsonWebTokenService.decode(request.headers['Authorization'].split(' ').last)
  end
end
