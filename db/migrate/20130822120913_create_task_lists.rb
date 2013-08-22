class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.belongs_to :owner

      t.timestamps
    end

    add_index :task_lists, :owner_id
  end
end
