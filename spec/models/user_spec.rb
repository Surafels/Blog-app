require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid when posts counter is not an integer' do
    user = User.new(name: 'John Isac', posts_counter: 'abc')
    expect(user).to_not be_valid
    expect(user.errors[:posts_counter]).to include('is not a number')
  end

  it 'is invalid when posts counter is less than zero' do
    user = User.new(name: 'John Isac', posts_counter: -1)
    expect(user.valid?).to be false
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end
end
