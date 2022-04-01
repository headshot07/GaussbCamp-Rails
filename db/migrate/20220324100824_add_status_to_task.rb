# frozen_string_literal: true

class AddStatusToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :status, :boolean, null: false, default: false
  end
end
