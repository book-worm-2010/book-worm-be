class Api::V1::BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.new(bookmark_params)
    if bookmark.save
      render json: BookmarkSerializer.new(bookmark), status: :created
    else
      render json: { 'error' => 'must include minutes' }, status: 404
    end
  end

  private

  def bookmark_params
    params.permit(:student_book_id, :date, :minutes, :page_number)
  end
end
