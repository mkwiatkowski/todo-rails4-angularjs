require 'spec_helper'

describe TaskListsController do
  context "for a logged-in user with a task list" do
    let(:task_list) { create(:task_list) }
    let(:user) { task_list.owner }
    before { sign_in(user) }

    describe "#show" do
      it "should return 200 for the task list" do
        get :show, id: task_list.id
        response.should be_ok
      end

      it "should raise RecordNotFound when task list doesn't exist" do
        expect {
          get :show, id: 1
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should return HTTP 401 Unauthorized when task list belongs to another user" do
        other_task_list = create(:task_list)
        get :show, id: other_task_list.id
        response.status.should == 401
      end
    end
  end
end
