require 'spec_helper'

describe Api::TasksController do
  describe "#index" do
    context "for user that has a task list with some tasks" do
      let(:task_list) { create(:task_list, :with_tasks) }
      let(:task1) { task_list.tasks[0] }
      let(:task2) { task_list.tasks[1] }
      let(:user) { task_list.owner }

      before do
        sign_in(user)
      end

      it "should return json of those tasks" do
        get :index, task_list_id: task_list.id
        tasks = JSON.parse(response.body)
        tasks.should == [
          {'id' => task1.id, 'description' => task1.description,
            'priority' => nil, 'due_date' => nil, 'completed' => false},
          {'id' => task2.id, 'description' => task2.description,
            'priority' => nil, 'due_date' => nil, 'completed' => false}
        ]
      end
    end
  end
end
