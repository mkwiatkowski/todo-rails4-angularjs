require 'spec_helper'

describe TemplatesController do
  
  describe "#index" do

    context "when logged in" do
      before { sign_in(create(:user)) }
      
      it "should return 200 for the index" do
        get :index
        response.should be_ok
      end

      it "should return 200 for the template" do
        get :template, path: 'task_list.html'
        response.should be_ok
      end
    end

    context "when not logged in" do
      
      it "should redirect to sign up for the index" do
        get :index
        response.should redirect_to(new_user_session_path)
      end

      it "should redirect to sign up for the template" do
        get :template, path: 'task_list.html'
        response.should redirect_to(new_user_session_path)
      end
    end

  end
end
