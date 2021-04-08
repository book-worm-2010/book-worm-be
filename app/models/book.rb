class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true

  class << self 
    def search(query)
      where('title ilike ?', "%#{query}%")
    end
  end
end