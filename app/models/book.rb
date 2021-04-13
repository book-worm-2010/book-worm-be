class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
  has_many :student_books
  has_many :students, through: :student_books

  class << self
    def search(query)
      where('title ilike ?', "%#{query}%")
    end
  end
end
