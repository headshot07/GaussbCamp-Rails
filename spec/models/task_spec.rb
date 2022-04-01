# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:all) do
    User.destroy_all
    @creator = User.create!(first_name: 'Sanjay', last_name: 'Singh', email: 'sanjaythakur1729@gmail.com',
                            password_digest: 'password123')
    @assignee = User.create!(first_name: 'Rishu', last_name: 'Roy', email: 'rishuroy123@gmail.com',
                             password_digest: 'password123')
    # @task = Task.create(title: '', body: 'Complete the project.', assignee_id: @assignee.id, creator_id: @creator.id)
  end

  it 'should have a title' do
    task = Task.create(title: '', body: 'Complete the project.', creator_id: @creator.id, assignee_id: @assignee.id,)
    expect(task).to_not be_valid
    task.title = 'Assignment'
    expect(task).to be_valid
  end

  it { should validate_presence_of(:title) }

  it 'should have a body' do
    task = Task.create(title: 'Assignment', body: '', assignee_id: @assignee.id, creator_id: @creator.id)
    expect(task).to_not be_valid
    task.body = 'Complete the project.'
    expect(task).to be_valid
  end

  it { should have_many(:comments) }

  it { should validate_presence_of(:assignee_id) }

  it { should validate_presence_of(:creator_id) }

  it { should belong_to(:assignee).class_name('User') }

  it { should belong_to(:creator).class_name('User') }
end
