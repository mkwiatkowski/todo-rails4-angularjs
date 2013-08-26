class Api::TaskListsController < Api::BaseController
  def index
    render json: [current_user.task_list]
  end
end
