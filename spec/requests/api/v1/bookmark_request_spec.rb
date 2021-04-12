require 'rails_helper'

describe "Bookmark API" do
    it "can create a bookmark" do
      student = create(:student)
      book = create(:book)
      student_book = StudentBook.create!(student_id: student.id, book_id: book.id)
      data = {
        "student_book_id": student_book.id,
        "date": Date.today,
        "minutes": 30,
      }
      # bookmarks do not have validations, so it's ok to leave a space blank (page number is not included)

      post '/api/v1/bookmarks', params: data

      expect(response).to be_successful
      bookmark = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(bookmark[:type]).to eq("bookmark")
      expect(bookmark[:attributes][:student_book_id]).to eq(student_book.id)
      expect(bookmark[:attributes][:date]).to eq(Date.today.to_s)
      expect(bookmark[:attributes][:minutes]).to eq(30)
      expect(bookmark[:attributes][:page_number]).to eq(nil)
    end
  end
