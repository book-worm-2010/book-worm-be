require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'relationships' do
    it { should belong_to :student_book }
  end
end
