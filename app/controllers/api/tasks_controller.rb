class Api::TasksController < Api::BaseController
  before_action :check_owner

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
    @task_list ||= TaskList.find(params[:task_list_id])
  end

  def task
    @task ||= task_list.tasks.find(params[:id])
  end

  def safe_params
    params.require(:task).permit(:description, :priority, :completed)
  end

  def check_owner
    permission_denied if current_user.task_list != task_list
  end
end
