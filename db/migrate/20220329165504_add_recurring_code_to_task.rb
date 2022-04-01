class AddRecurringCodeToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :recurring_code, :integer, default: 0
  end
end
