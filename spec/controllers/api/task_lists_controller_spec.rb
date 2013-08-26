require 'spec_helper'

describe Api::TaskListsController do
  describe "#index" do
    context "for user that has a task list" do
      let(:user) { create(:user) }

      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should return json of array of those task lists" do
          get :index
          tasks = JSON.parse(response.body)
          tasks.should == [{'id' => user.task_list.id}]
        end
      end

      it "should return error json with 401 HTTP status when not authenticated" do
        get :index
        tasks = JSON.parse(response.body)
        tasks.should == {'error' => 'unauthorized'}
        response.status.should == 401
      end
    end
  end
end
