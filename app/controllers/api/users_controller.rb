# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :authorize_request, except: [:create]
  def index
    puts request.headers['Authorization']
    users = User.all
    if users
      render json: { users: UserSerializer.new(users) }, status: 200
    else
      render json: { }, status: 501
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { }, status: 200
    else
      render json: { errors: user.errors.full_messages }, status: 501
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_update_params)
    render json: { user: UserSerializer.new(user) }, status: 200
  end

  def show
    user = User.find(params[:id])
    if user
      render json: { user: UserSerializer.new(user) }, status: 200
    else
      render json: { }, status: 501
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
