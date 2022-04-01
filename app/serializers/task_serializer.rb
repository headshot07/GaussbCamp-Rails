# frozen_string_literal: true

class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body, :assignee, :creator, :status, :due_date, :created_at, :recurring_code

  # belongs_to :assignee, class_name: 'User'
  # belongs_to :creator, class_name: 'User'
  # has_many :comments
end
