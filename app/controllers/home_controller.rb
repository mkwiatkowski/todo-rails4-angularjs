class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to task_lists_path
    end
  end
end
