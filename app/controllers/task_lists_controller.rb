class TaskListsController < ApplicationController
  def show
    @task_list = TaskList.find(params[:id])
  end
end
