class Student < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :student_books
  has_many :books, through: :student_books
end
