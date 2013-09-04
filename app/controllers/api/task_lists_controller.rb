class Api::TaskListsController < Api::BaseController
  before_action :check_owner, only: [:show, :destroy]

  def index
    render json: current_user.task_lists
  end

  def show
    render json: task_list
  end

  def create
    name = params[:list][:name] || "New list"
    list = TaskList.create(owner_id: current_user.id, name: name)
    render json: list
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
end
