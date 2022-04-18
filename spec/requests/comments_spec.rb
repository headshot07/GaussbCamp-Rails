# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before(:all) do
    User.destroy_all
    @creator = User.create!(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjaythakur1729@gmail.com',
                            password_digest: 'password123')
    @assignee = User.create!(first_name: 'Rishu', last_name: 'Roy', email: 'rishuroy123@gmail.com',
                             password_digest: 'password123')
    @task = Task.create(title: 'Assignment Third', body: 'Complete the third assignment.', assignee_id: @assignee.id,
                        creator_id: @creator.id)
    @token = JWT.encode({ user_id: @creator.id }, 'HelloWorld', 'HS256')
  end

  let(:valid_attributes) do
    { body: 'Assignment Completed' }
  end

  let(:invalid_attributes) do
    { body: '' }
  end

  describe 'GET /index' do
    it 'should render successful response' do
      get api_user_task_comments_path(user_id: @creator.id, task_id: @task.id),
          headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    it 'should create a comment on the task' do
      before_count = Comment.count
      post api_user_task_comments_path(user_id: @creator.id, task_id: @task.id), params: { comment: valid_attributes },
                                                                             headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
      expect(Comment.count).to_not eq(before_count)
    end

    it 'should not create a comment on the task' do
      before_count = Comment.count
      post api_user_task_comments_path(user_id: @creator.id, task_id: @task.id), params: { comment: invalid_attributes },
                                                                             headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(501)
      expect(Comment.count).to eq(before_count)
    end
  end

  describe 'DELETE /destroy' do
    it 'should delete the comment' do
      comment = Comment.create(body: 'New Comment', user_id: @creator.id, task_id: @task.id)
      delete api_user_task_comment_path(user_id: @creator.id, task_id: @task.id, id: comment.id), headers: { 'Authorization' => "Bearer #{@token}" }
      expect(response).to have_http_status(200)
    end
  end
end
