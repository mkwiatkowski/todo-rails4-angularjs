class TaskListsController < ApplicationController
  def show
    @task_list = TaskList.find(params[:id])
    permission_denied if @task_list.owner != current_user
  end
end
