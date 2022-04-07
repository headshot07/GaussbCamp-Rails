# frozen_string_literal: true

require 'date'

class Task < ApplicationRecord
  belongs_to :assignee, class_name: 'User'
  belongs_to :creator, class_name: 'User'

  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :assignee_id, presence: true
  validates :creator_id, presence: true

  def self.weekday_code(day)
    return 0 if day == 'Sunday'
    return 1 if day == 'Monday'
    return 2 if day == 'Tuesday'
    return 3 if day == 'Wednesday'
    return 4 if day == 'Thursday'
    return 5 if day == 'Friday'
    return 6 if day == 'Saturday'
  end

  def self.last_weekday?
    date = Date.today
    diff = ((date + 7).year * 12 + (date + 7).month) - (date.year * 12 + date.month)
    return false if diff.zero?

    true
  end

  def self.get_week_code
    (Date.today.to_date.strftime('%d').to_f / 7).ceil
  end

  def self.task_recreate
    check_last_weekday = last_weekday?
    today_date = Date.today.to_date

    if check_last_weekday
      weekday_code = '7'
      today_day = Date.today.strftime('%A')
      day_code = weekday_code(today_day).to_s
      recurring_code = (weekday_code + day_code).to_i
      task_last_weekday = Task.where(recurring_code:)
      task_last_weekday.each do |task|
        Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                    due_date: today_date + 30, recurring_code: 0)
      end
    else
      today_day = Date.today.strftime('%A')
      day_code = weekday_code(today_day).to_s
      week_code = get_week_code.to_s

      recurring_code = (week_code + day_code).to_i
      tasks = Task.where(recurring_code:)
      tasks.each do |task|
        Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                    due_date: today_date + 30, recurring_code: 0)
      end
    end

    today_date = Date.today.to_date
    task_every_day = Task.where(recurring_code: 1)
    task_every_day.each do |task|
      Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                  due_date: today_date + 1, recurring_code: 0)
    end

    task_every_week = Task.where(recurring_code: 2)
    task_every_week.each do |task|
      created_date = task.created_at.to_date
      diff = (today_date - created_date).to_i
      if diff == 7
        Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                    due_date: today_date + 7, recurring_code: 0)
      end
    end

    task_every_twice_week = Task.where(recurring_code: 4)
    task_every_twice_week.each do |task|
      created_date = task.created_at.to_date
      diff = (today_date - created_date).to_i
      if diff == 14
        Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                    due_date: today_date + 14, recurring_code: 0)
      end
    end

    task_every_month = Task.where(recurring_code: 4)
    task_every_month.each do |task|
      created_date_day = task.created_at.to_date.day
      today_date_day = today_date.day
      if created_date_day == today_date_day
        Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                    due_date: today_date + 30, recurring_code: 0)
      end
    end

    task_every_year = Task.where(recurring_code: 5)
    task_every_year.each do |task|
      created_date = task.created_at.to_date
      diff = (today_date - created_date).to_i
      if diff == 365
        Task.create(title: task.title, body: task.body, creator_id: task.creator_id, assignee_id: task.assignee_id, status: false,
                    due_date: today_date + 365, recurring_code: 0)
      end
    end
  end
end
