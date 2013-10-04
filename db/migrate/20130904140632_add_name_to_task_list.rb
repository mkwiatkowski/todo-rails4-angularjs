class AddNameToTaskList < ActiveRecord::Migration
  def change
    add_column :task_lists, :name, :string
  end
end
