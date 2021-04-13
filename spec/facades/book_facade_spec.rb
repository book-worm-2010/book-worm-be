require 'rails_helper'

describe BookFacade do 
  describe "book info", :vcr do 
    it "it create poros of book info through google books api" do 
      params = {title: "Harry Potter and the Sorcerer's Stone",
              author: "J. K. Rowling"}
      book = BookFacade.book_info(params)
      
      expect(book).to have_attributes(title: "Harry Potter and the Sorcerer's Stone",
                                      author: "J. K. Rowling",
                                      pages: 336
      )
    end
  end
end