require 'spec_helper'

describe Api::TaskListsController do
  describe "#index" do
    context "for user that has a task list" do
      let(:user) { create(:user) }

      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should return json of array of those task lists" do
          get :index
          json_response.should == [{'id' => user.task_list.id}]
        end
      end

      it "should return error json with 401 HTTP status when not authenticated" do
        get :index, format: :json
        response.status.should == 401
        json_response.should == {'error' => 'You need to sign in or sign up before continuing.'}
      end
    end
  end
end
