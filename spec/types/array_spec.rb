require 'spec_helper'
require 'ostruct'

describe BlankAttributes::Types::Array do
  let(:user) { User.new }
  before { clean_database }

  it 'should set an empty an array for an empty string' do
    user.profile_ids = ''
    user.valid?
    expect(user.profile_ids).to eq []
  end

  it 'should set an empty array for an array with a single empty string' do
    user.profile_ids = ['']
    user.valid?
    expect(user.profile_ids).to eq []
  end

  it 'should set an empty array for an array with multiple empty strings' do
    user.profile_ids = ['', '', '']
    user.valid?
    expect(user.profile_ids).to eq []
  end

  it 'should set an empty array for an array with a single blank string' do
    user.profile_ids = [' ']
    user.valid?
    expect(user.profile_ids).to eq []
  end

  it 'should set an empty array for an array with multiple blank strings' do
    user.profile_ids = [' ', ' ', ' ']
    user.valid?
    expect(user.profile_ids).to eq []
  end

  it 'should set an empty array for an array with multiple blank values' do
    user.profile_ids = [' ', nil, '']
    user.valid?
    expect(user.profile_ids).to eq []
  end

  it 'should set an correct array' do
    user.profile_ids = ['', ' ', nil, 1]
    user.valid?
    expect(user.profile_ids).to eq [1]
  end

  it 'should return a same array if values are correct' do
    arr = [1, '2']
    user.profile_ids = arr
    user.valid?
    expect(user.profile_ids).to eq arr
  end
end
