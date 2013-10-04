class Api::TaskListsController < Api::BaseController
  before_action :check_owner, only: [:show, :update, :destroy]

  def index
    render json: current_user.task_lists
  end

  def show
    render json: task_list
  end

  def create
    list = current_user.task_lists.create!(safe_params)
    render json: list
  end

  def update
    task_list.update_attributes(safe_params)
    render nothing: true
  end

  def destroy
    task_list.destroy
    render nothing: true
  end

  private
  def check_owner
    permission_denied if current_user != task_list.owner
  end

  def task_list
    @task_list ||= TaskList.find(params[:id])    
  end

  def safe_params
    params.require(:list).permit(:name)
  end
end
