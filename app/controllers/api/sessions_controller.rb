# frozen_string_literal: true

class Api::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
    if user
      jwt_token = JWT.encode({ user_id: user.id }, 'HelloWorld', 'HS256')
      render json: { user: UserSerializer.new(user), token: jwt_token }, status: 200
    else
      render json: { errors: ['Not Found', 'Email Not Found', 'User Not Found'] }, status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
