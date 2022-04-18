# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before(:all) do
    @user = User.create(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjay123@gmail.com', password: 'password123')
  end
  describe 'POST /create' do
    it 'should create a new login/session' do
      post api_sessions_path, params: { user: { email: 'sanjay123@gmail.com', password: 'password123' } }
      expect(response).to have_http_status(200)
    end
  end
end
