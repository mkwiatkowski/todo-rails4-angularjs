class Api::TaskListsController < Api::BaseController
  def index
    render json: current_user.task_lists
  end

  def create
    list = TaskList.create(owner_id: current_user.id)
    render json: list
  end
end
