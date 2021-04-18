require 'rails_helper'

describe 'Bookmark API' do
  it 'can create a bookmark' do
    student = create(:student)
    book = create(:book)
    student_book = StudentBook.create!(student_id: student.id, book_id: book.id)
    data = {
      "student_id": student.id,
      "book_id": book.id,
      "date": Date.today,
      "page_number": 30
    }
    # bookmarks do not have validations other than page_number, so it's ok to leave a space blank (page number is not included)

    post '/api/v1/bookmarks', params: data

    expect(response).to be_successful
    bookmark = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(bookmark[:type]).to eq('bookmark')
    expect(bookmark[:attributes][:student_book_id]).to eq(student_book.id)
    expect(bookmark[:attributes][:date]).to eq(Date.today.to_s)
    expect(bookmark[:attributes][:page_number]).to eq(30)
    expect(bookmark[:attributes][:minutes]).to eq(nil)
  end

  it 'throws an error if a bookmark cannot be created' do
    student = create(:student)
    book = create(:book)
    student_book = StudentBook.create!(student_id: student.id, book_id: book.id)
    data = {
      "student_id": student.id,
      "book_id": book.id,
      "date": Date.today
    }

    post '/api/v1/bookmarks', params: data

    expect(response).to_not be_successful
    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:error]).to eq('something went wrong, or must include page number')
  end
end
