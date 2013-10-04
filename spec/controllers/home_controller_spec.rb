require 'spec_helper'

describe HomeController do
  let(:user) { create(:user) }

  describe "#index" do
    it "should render when user is not signed in" do
      get :index
      response.should be_ok
      response.should render_template('index')
    end

    it "should redirect to the dashboard if signed in" do
      sign_in(user)
      get :index
      response.should redirect_to(dashboard_path)
    end
  end
end
