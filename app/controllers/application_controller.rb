class ApplicationController < ActionController::Base
  protect_from_forgery

  def permission_denied
    render file: "public/401.html", layout: false, status: :unauthorized
  end
end
