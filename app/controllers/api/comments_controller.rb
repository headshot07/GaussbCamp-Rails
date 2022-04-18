# frozen_string_literal: true

class Api::CommentsController < ApplicationController
  before_action :authorize_request
  def index
    comments = Task.find(params[:task_id]).comments
    render json: { comments: CommentSerializer.new(comments) }, status: 200
  end

  def create
    task = Task.find(params[:task_id])
    comment = task.comments.new(body: params[:comment][:body], user_id: params[:user_id], task_id: params[:task_id])
    if comment.save
      render json: { }, status: 200
    else
      render json: { error: comment.errors.full_messages }, status: 501
    end
  end

  def destroy
    Comment.destroy(params[:id])
    render json: { }, status: 200
  end
end
