class BookmarkSerializer
  include FastJsonapi::ObjectSerializer
  attributes :student_book_id, :date, :minutes, :page_number, :notes, :reactions
end
