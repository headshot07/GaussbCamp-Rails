# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :email

  # has_many :tasks
  # has_many :comments
end
