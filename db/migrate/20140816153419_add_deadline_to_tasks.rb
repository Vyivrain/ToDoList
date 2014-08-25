class AddDeadlineToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :dead_line, :datetime
  end
end
