require 'spec_helper'

describe Api::TasksController do
  context "for a logged-in user with two tasks" do
    let(:user) { create(:user) }
    let(:task_list) { user.task_lists.first }
    let(:task1) { task_list.tasks[0] }
    let(:task2) { task_list.tasks[1] }

    before do
      2.times { create(:task, list: task_list) }
      sign_in(user)
    end

    describe "#index" do
      it "should return json of those tasks" do
        get :index, task_list_id: task_list.id
        json_response.should == [
          {'id' => task1.id, 'description' => task1.description,
            'priority' => 1, 'due_date' => nil, 'completed' => false},
          {'id' => task2.id, 'description' => task2.description,
            'priority' => 2, 'due_date' => nil, 'completed' => false}
        ]
      end

      it "should raise RecordNotFound when trying to get tasks for non-existent list" do
        expect {
          get :index, task_list_id: 0
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should return HTTP 401 Unauthorized when trying to get tasks for list of another user" do
        other_task_list = create(:task_list)
        get :index, task_list_id: other_task_list.id
        response.status.should == 401
        json_response.should == {'error' => 'unauthorized'}
      end
    end

    describe "#create" do
      let(:post_create) do
        post :create, task_list_id: task_list.id, task: {description: "New task"}
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

      it "should return json of the just created record" do
        post_create
        json_response["id"].should == be_an(Integer)
        json_response["completed"].should == false
        json_response["description"].should == "New task"
        json_response["due_date"].should == nil
      end

      it "should put the new task on top of the list" do
        t1, t2 = task1, task2
        post_create
        json_response["priority"].should == 1
        t1.reload.priority.should == 2
        t2.reload.priority.should == 3
      end

      it "should raise ParameterMissing exception when task param is missing" do
        expect {
          post :create, task_list_id: task_list.id
        }.to raise_error(ActionController::ParameterMissing)
      end

      it "should ignore unknown parameters" do
        post :create, task_list_id: task_list.id,
          task: {description: "New task", foobar: 1234}
        response.status.should == 201
      end

      it "should raise a validation error when description is too long" do
        expect {
          post :create, task_list_id: task_list.id, task: {description: "a"*300}
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "should return HTTP 401 Unauthorized when trying to create task in a list of another user" do
        other_task_list = create(:task_list)
        post :create, task_list_id: other_task_list.id, task: {description: "Not mine"}
        response.status.should == 401
        json_response.should == {'error' => 'unauthorized'}
      end
    end

    describe "#update" do
      let(:patch_update) do
        patch :update, task_list_id: task_list.id, id: task1.id,
          task: {description: "New description", target_priority: 2, completed: true}
      end

      it "should update passed parameters of the given task" do
        patch_update
        task1.reload.description.should == "New description"
        task1.priority.should == 2
        task1.completed.should be_true
      end

      it "should return 200 OK" do
        patch_update
        response.should be_success
      end

      it "should raise RecordNotFound when trying to update non-existent task" do
        expect {
          patch :update, task_list_id: task_list.id, id: 0,
            task: {description: "New description"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should return HTTP 401 Unauthorized when trying to update task of another user" do
        other_task = create(:task)
        patch :update, task_list_id: other_task.list.id, id: other_task.id,
          task: {description: "New description"}
        response.status.should == 401
        json_response.should == {'error' => 'unauthorized'}
      end

      it "should accept unix timestamps as value of due_date" do
        patch :update, task_list_id: task_list.id, id: task1.id,
          task: {due_date: '2009-02-14'}
        task1.reload.due_date.should == Date.new(2009, 2, 14)
      end
    end

    describe "#destroy" do
      let(:delete_destroy) do
        delete :destroy, task_list_id: task_list, id: task1.id
      end

      it "should remove the task from database" do
        delete_destroy
        expect { task1.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should return 200 OK" do
        delete_destroy
        response.should be_success
      end

      it "should raise RecordNotFound when trying to destroy non-existent task" do
        expect {
          delete :destroy, task_list_id: task_list.id, id: 0
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should return HTTP 401 Unauthorized when trying to delete task of another user" do
        other_task = create(:task)
        delete :destroy, task_list_id: other_task.list.id, id: other_task.id
        response.status.should == 401
        json_response.should == {'error' => 'unauthorized'}
      end
    end
  end
end
