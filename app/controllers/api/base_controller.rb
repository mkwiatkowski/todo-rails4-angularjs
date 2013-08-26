class Api::BaseController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    permission_denied if !user_signed_in?
  end

  def permission_denied
    render json: {error: 'unauthorized'}, status: :unauthorized
  end
end
