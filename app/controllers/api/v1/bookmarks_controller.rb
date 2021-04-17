class Api::V1::BookmarksController < ApplicationController
  def create
    student_book = StudentBook.where(student_id: params[:student_id], book_id: params[:book_id]).first
    bookmark = Bookmark.new(bookmark_params)
    bookmark.update(student_book_id: student_book.id)
    if bookmark.save
      render json: BookmarkSerializer.new(bookmark), status: :created
    else
      render json: { 'error' => 'something went wrong, or must include page number' }, status: 404
    end
  end

  private

  def bookmark_params
    params.permit(:date, :minutes, :page_number)
  end
end
