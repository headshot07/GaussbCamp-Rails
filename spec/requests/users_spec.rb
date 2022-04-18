# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:all) do
    User.destroy_all
    @user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh123@gaussb.com',
                        password: 'password123')
    @token = JWT.encode({ user_id: @user.id }, 'HelloWorld', 'HS256')
  end
  let(:valid_attributes) do
    { first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh12345@gaussb.com', password: 'password123' }
  end

  let(:invalid_attributes) do
    { first_name: '', last_name: '', email: 'sanjay.singh@gaussb.com', password: 'password123' }
  end

  describe 'GET /index' do
    it 'should render a successful response' do
      get api_users_url, headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    it 'should create the user and render successful response' do
      before_count = User.count
      post api_users_url, params: { user: valid_attributes }, headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
      expect(User.count).not_to eq(before_count)
    end

    it 'should not create the user and render unsuccessful response' do
      before_count = User.count
      post api_users_url, params: { user: invalid_attributes }
      expect(response).to have_http_status(501)
      expect(User.count).to eq(before_count)
    end
  end

  describe 'GET /show' do
    it 'should show the user details' do
      get api_user_path(@user.id), headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /update' do
    it 'should update the user' do
      put api_user_path(@user.id),
          params: { user: { first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay.singh123@gaussb.com' } },
          headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end
end
