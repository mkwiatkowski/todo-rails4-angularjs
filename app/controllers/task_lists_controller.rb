class TaskListsController < ApplicationController
  def show
    @task_list = TaskList.find_by_id(params[:id])
  end
end
