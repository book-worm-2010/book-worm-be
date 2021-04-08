require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end
  describe 'relationships' do
    it { should have_many(:student_books) }
    it { should have_many(:books).through(:student_books) }
  end
end
