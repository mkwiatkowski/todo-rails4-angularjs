require 'spec_helper'

describe TaskListsController do
  describe "#show" do
    it "should return 200 for existing task list" do
      task_list = create(:task_list)
      get :show, id: task_list.id
      response.should be_ok
    end

    it "should return 404 when task list doesn't exist" do
      expect {
        get :show, id: 1
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
