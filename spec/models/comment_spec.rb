# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    User.destroy_all
    @creator = User.create!(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjaythakur1729@gmail.com',
                            password_digest: 'password123')
    @assignee = User.create!(first_name: 'Rishu', last_name: 'Roy', email: 'rishuroy123@gmail.com',
                             password_digest: 'password123')
    @task = Task.create(title: 'Assignment', body: 'Complete the assignment', assignee_id: @assignee.id,
                        creator_id: @creator.id)
  end

  it 'should have a body' do
    comment = Comment.create(body: '', user_id: @creator.id, task_id: @task.id)
    expect(comment).to_not be_valid
    comment.body = 'Assignment has been completed.'
    expect(comment).to be_valid
  end

  it 'should have a task_id' do
    comment = Comment.create(body: 'Assignment Done', user_id: @creator.id, task_id: '')
    expect(comment).to_not be_valid
    comment.task_id = @task.id
    expect(comment).to be_valid
  end

  it 'should have a user_id' do
    comment = Comment.create(body: 'Assignment Done', user_id: '', task_id: @task.id)
    expect(comment).to_not be_valid
    comment.user_id = @creator.id
    expect(comment).to be_valid
  end

  it { should belong_to(:task) }

  it { should belong_to(:user) }
end
