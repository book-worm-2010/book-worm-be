class Student < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :student_books
  has_many :books, through: :student_books

  def self.from_omniauth(auth)
    require 'pry'; binding.pry
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |student|
      student.name = auth.info.name
      student.email = auth.info.email
    end
  end

  def specific_books(status)
    books.where('student_books.status = ?', status)
  end
end
