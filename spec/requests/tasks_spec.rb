# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  before(:all) do
    User.destroy_all
    @creator = User.create!(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjaythakur1729@gmail.com',
                            password_digest: 'password123')
    @assignee = User.create!(first_name: 'Rishu', last_name: 'Roy', email: 'rishuroy123@gmail.com',
                             password_digest: 'password123')
    @token = JWT.encode({ user_id: @creator.id }, 'HelloWorld', 'HS256')
  end

  let(:valid_attributes) do
    { title: 'Assignment', body: 'Complete the assignment', creator_id: @creator.id, assignee_id: @assignee.id }
  end

  let(:invalid_attributes) do
    { title: '', body: 'Complete the assignment', creator_id: @creator.id, assignee_id: @assignee.id }
  end

  describe 'GET /index' do
    it 'should render a successful response' do
      get user_tasks_path(user_id: @creator.id), headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    it 'should create a task and render successful response' do
      before_count = Task.count
      post user_tasks_path(user_id: @creator.id), params: { task: valid_attributes }, headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
      expect(Task.count).to_not eq(before_count)
    end

    it 'should not create a task and render unsuccessful response' do
      before_count = Task.count
      post user_tasks_path(user_id: @creator.id), params: { task: invalid_attributes }, headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(501)
      expect(Task.count).to eq(before_count)
    end
  end

  describe 'GET /show' do
    it 'should render the successful response' do
      task = Task.create(title: 'Assignment Third', body: 'Complete the third assignment.', assignee_id: @assignee.id,
                         creator_id: @creator.id)
      get user_task_path(user_id: @creator.id, id: task.id), headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /change_status' do
    it 'should update the status of task' do
      task = Task.create(title: 'Assignment Third', body: 'Complete the third assignment.', assignee_id: @assignee.id,
                         creator_id: @creator.id, status: false)
      post "/tasks/#{task.id}/edit", params: { status: true }, headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end
end
