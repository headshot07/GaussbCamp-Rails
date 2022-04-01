# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authorize_request
  def index
    assigned_tasks = User.find(params[:user_id]).assignee_tasks
    created_tasks = User.find(params[:user_id]).creator_tasks
    render json: { assigned_tasks: TaskSerializer.new(assigned_tasks), created_tasks: TaskSerializer.new(created_tasks) },
           status: 200
  end

  def create
    puts params
    user = User.find(params[:user_id])
    task = user.creator_tasks.new(task_params)
    if task.save
      render json: {}, status: 200
    else
      render json: { error: task.errors.full_messages }, status: 501
    end
  end

  def show
    task = Task.find(params[:id])
    render json: { task: TaskSerializer.new(task) }, status: 200
  end

  def change_status
    puts params[:status]
    task = Task.find(params[:task_id])
    task.update(status: params[:status])
    render json: {}, status: 200
  end

  def destroy
    Task.delete(params[:id])
    render json: {}, status: 200
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, :creator_id, :assignee_id, :due_date, :recurring_code)
  end
end
