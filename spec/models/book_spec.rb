require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
  end

  describe 'relationships' do
    it { should have_many(:student_books) }
    it { should have_many(:students).through(:student_books) }
  end
end
