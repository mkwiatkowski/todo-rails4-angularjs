class Api::SessionsController < Devise::SessionsController
  before_action :warden_authenticate

  def create
    sign_in(resource_name, resource)
    resource.reset_authentication_token!
    render json: {auth_token: resource.authentication_token}
  end

  def destroy
    sign_out(resource_name)
    resource.clear_authentication_token!
    render nothing: true
  end

  private

  def warden_authenticate
    self.resource = warden.authenticate!(auth_options)
  end
end
