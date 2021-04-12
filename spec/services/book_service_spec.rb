require 'rails_helper'

describe BookService do
  context "instance methods" do
    it "can make API call to database", :vcr do
      search_params = "Harry Potter and the Goblet of Fire"
      author = "J.K. Rowling"
      query = BookService.call_googlebooks(search_params, author)

      expect(query).to be_a Hash
      expect(query[:items].count).to eq(10)
      expect(query[:items].first).to have_key(:volumeInfo)
      expect(query[:items].first[:volumeInfo]).to have_key(:title)
      expect(query[:items].first[:volumeInfo]).to have_key(:authors)
      expect(query[:items].first[:volumeInfo]).to have_key(:description)
      expect(query[:items].first[:volumeInfo]).to have_key(:pageCount)
      expect(query[:items].first[:volumeInfo]).to have_key(:maturityRating)
      expect(query[:items].first[:volumeInfo]).to have_key(:imageLinks)
    end
  end
end
