# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a first_name' do
    user = User.create(first_name: '', last_name: 'Singh', email: 'sanjay.singh@gaussb.com',
                       password_digest: 'password123')
    expect(user).to_not be_valid
    user.first_name = 'Sanjay'
    expect(user).to be_valid
  end

  # it { should validate_presence_of(:first_name) }

  it 'should have an email' do
    user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: '', password_digest: 'password123')
    expect(user).to_not be_valid
    user.email = 'sanjay.singh@gaussb.com'
    expect(user).to be_valid
  end

  it 'should have a password' do
    user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh@gaussb.com',
                       password_digest: '')
    expect(user).to_not be_valid
    user.password_digest = 'password123'
    expect(user).to be_valid
  end

  it 'should have a password with minimum length 5' do
    user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh@gaussb.com',
                       password_digest: 'pass')
    expect(user).to_not be_valid
    user.password_digest = 'password123'
    expect(user).to be_valid
  end

  it { should validate_uniqueness_of(:email) }

  it 'should have a unique email' do
    first_user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh@gaussb.com',
                             password_digest: 'password')
    second_user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh@gaussb.com',
                              password_digest: 'password')
    expect(second_user).to_not be_valid
    # validate_uniqueness_of(:email)
  end

  it { should have_many(:creator_tasks) }

  it { should have_many(:assignee_tasks) }
end
