# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_action :verify_authenticity_token

  def authorize_request
    header = request.headers['Authorization']
    token  = header.split(' ')[1]
    pay_load = JWT.decode(token, 'HelloWorld', true, algorithm: 'HS256')
    user_id = pay_load[0]['user_id']
    user = User.find(user_id)
    render json: { error: 'Unauthorized User' }, status: 501 unless user
  end
end
