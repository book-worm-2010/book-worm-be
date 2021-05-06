class Student < ApplicationRecord
  attr_accessor :google_token

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :google_token, presence: true, uniqueness: true
  has_many :student_books
  has_many :books, through: :student_books

  def authenticate(token)
    if BCrypt::Token.new(token) == google_token
      self
    else
      false
    end
  end

  def specific_books(status)
    books.where('student_books.status = ?', status)
  end
end
