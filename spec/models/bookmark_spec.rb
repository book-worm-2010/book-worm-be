require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'relationships' do
    it { should belong_to :student_book }
  end
  describe 'validations' do
    it { should validate_presence_of :page_number }
  end
end
