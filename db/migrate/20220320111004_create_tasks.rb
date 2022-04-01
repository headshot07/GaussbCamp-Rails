class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :body
      t.references :assignee, foreign_key: { to_table: :users }, null: false
      t.references :creator, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
