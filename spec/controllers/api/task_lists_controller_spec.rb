require 'spec_helper'

describe Api::TaskListsController do
  describe "#index" do
    context "for user that has a task list" do
      let(:user) { create(:user) }
      before { sign_in(user) }

      it "should return json of array of those task lists" do
        get :index
        tasks = JSON.parse(response.body)
        tasks.should == [{'id' => user.task_list.id}]
      end
    end
  end
end
