require 'spec_helper'

describe Api::TasksController do
  context "for a new logged-in user" do
    let(:user) { create(:user) }
    before { sign_in(user) }

    describe "#index" do
      context "for a task list with some tasks" do
        let(:task_list) { create(:task_list, :with_tasks, owner: user) }
        let(:task1) { task_list.tasks[0] }
        let(:task2) { task_list.tasks[1] }

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

    describe "#create" do
      let(:post_create) do
        post :create, task_list_id: user.task_list.id, description: "New task"
      end

      it "should add the record to the database" do
        expect {
          post_create
        }.to change(Task, :count).by(1)
      end

      it "should return 200 OK" do
        post_create
        response.should be_success
      end
    end
  end
end
