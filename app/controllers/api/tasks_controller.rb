class Api::TasksController < ApplicationController
  def index
    render json: task_list.tasks
  end

  def create
    task_list.tasks.create!(params.permit(:description))
    render nothing: true
  end

  private
  def task_list
    TaskList.find_by_id(params[:task_list_id])
  end
end
