require 'rails_helper'

describe 'StudentBooks API' do
  describe 'dashboard' do
    it 'creates a new relationship' do
      student = create(:student)
      book = create(:book)
      data = {
        "student_id": student.id,
        "book_id": book.id
      }

      #get api/v1/student_books
      post api_v1_student_books_path, params: data

      expect(response).to be_successful
      new_book = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(new_book[:attributes][:student_id]).to eq(student.id)
      expect(new_book[:attributes][:book_id]).to eq(book.id)
      expect(new_book[:attributes][:status]).to eq(nil)
    end
  end
end
