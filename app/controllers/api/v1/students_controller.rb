class Api::V1::StudentsController < ApplicationController
  def books
    @student = Student.find(params[:id])
    @books = @student.books
    render json: BookSerializer.new(@books.paginate(params[:per_page], params[:page]))
  end
end
