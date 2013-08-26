class Api::TasksController < ApplicationController
  def index
    render json: task_list.tasks
  end

  def create
    task = task_list.tasks.create!(safe_params)
    render json: task
  end

  def update
    task.update_attributes(safe_params)
    render nothing: true
  end

  def destroy
    task.destroy
    render nothing: true
  end

  private
  def task_list
    TaskList.find_by_id(params[:task_list_id])
  end

  def task
    task_list.tasks.find_by_id(params[:id])
  end

  def safe_params
    params.require(:task).permit(:description, :priority, :completed)
  end
end
