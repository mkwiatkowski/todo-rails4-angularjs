class Api::TaskListsController < ApplicationController
  def index
    render json: [current_user.task_list]
  end
end
