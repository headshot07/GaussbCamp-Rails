class User < ApplicationRecord
  has_secure_password
  has_many :creator_tasks, class_name: 'Task', foreign_key: 'creator_id', dependent: :destroy
  has_many :assignee_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: :destroy
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 5 }
end
