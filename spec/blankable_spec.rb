require 'spec_helper'

describe BlankAttributes::Blankable do
  let(:user) { User.new name: '', email: 'mail@mail.com' }
  before { clean_database }

  describe 'Model class methods' do
    it 'has a :blankable_attributes' do
      expect(User.respond_to?(:blankable_attributes)).to be true
    end

    it 'has a :blankable_attributes=' do
      expect(User.respond_to?('blankable_attributes=')).to be true
    end

    it 'has a :has_blankable_attribute?' do
      expect(User.respond_to?('has_blankable_attribute?')).to be true
    end
  end

  describe '#blankable_attributes' do
    it 'should have blankable attriutes' do
      expect(user.blankable_attributes).to eq [:name]
    end
  end

  describe '#blankable_attributes=' do
    it 'for model object the list of blankable attriutes can be changed' do
      user.blankable_attributes = []
      expect(user.blankable_attributes).to eq []
      expect(User.blankable_attributes).to eq [:name]
    end
  end

  describe '.has_blankable_attribute?' do
    it 'should return true' do
      expect(User.has_blankable_attribute?).to be true
    end
  end

  describe '#has_blankable_attribute?' do
    it 'should return true' do
      expect(user.has_blankable_attribute?).to be true
    end
  end
end
