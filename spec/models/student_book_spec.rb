require 'rails_helper'

RSpec.describe StudentBook, type: :model do
  describe 'relationships' do
    it { should belong_to :book }
    it { should belong_to :student }
    it { should have_many :bookmarks }
  end
end
