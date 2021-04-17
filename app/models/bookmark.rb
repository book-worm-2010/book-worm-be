class Bookmark < ApplicationRecord
  belongs_to :student_book
  validates_presence_of :minutes
end
