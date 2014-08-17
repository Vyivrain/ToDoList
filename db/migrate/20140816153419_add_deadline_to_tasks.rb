class AddDeadlineToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :dead_line, :string
  end
end
