class StudentBook < ApplicationRecord
  belongs_to :book
  belongs_to :student
  has_many :bookmarks
end
