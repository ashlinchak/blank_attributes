require 'spec_helper'

describe BlankAttributes::Types::String do
  let(:user) { User.new name: '', email: 'mail@mail.com' }
  before { clean_database }

  it 'should set to nil empty string' do
    user.name = ''
    user.valid?
    expect(user.name).to eq nil
  end

  it 'should set to nil string that contain only space' do
    user.name = ' '
    user.valid?
    expect(user.name).to eq nil
  end

  it 'should not change not blank value' do
    str = 'str'
    user.name = str
    user.valid?
    expect(user.name).to eq str
  end
end
