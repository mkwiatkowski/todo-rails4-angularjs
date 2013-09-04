class Api::TaskListsController < Api::BaseController
  def index
    render json: current_user.task_lists
  end

  def create
    list = TaskList.create(owner_id: current_user.id)
    render json: list
  end

  def destroy
    list = TaskList.find(params[:id])
    check_owner(list)
    list.destroy
    render nothing: true
  end

  private
  def check_owner(task_list)
    permission_denied if current_user != task_list.owner
  end
end
