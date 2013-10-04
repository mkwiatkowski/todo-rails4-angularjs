class FillEmptyNamesInTaskLists < ActiveRecord::Migration
  def change
    TaskList.update_all "name = 'My First List'", "name IS NULL"
  end
end
