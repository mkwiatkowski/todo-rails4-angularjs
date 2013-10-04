require 'spec_helper'

describe Api::TaskListsController do
  context "for user that has two task lists" do
    let(:user) { create(:user) }
    let(:first_list) { user.first_list }
    let(:second_list) { user.task_lists.last }
    let(:other_list) { create(:task_list) }

    before do
      create(:task_list, owner: user)
    end

    describe "#index" do    
      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should return json of array with that task list" do
          get :index
          json_response.should == [{"id" => second_list.id, "name" => second_list.name, "tasks" => second_list.tasks},
            {"id" => first_list.id, "name" => first_list.name, "tasks" => first_list.tasks}]
        end
      end

      context "when not authenticated as that user" do
        it "should return error json with 401 HTTP status" do
          get :index, format: :json
          response.status.should == 401
          json_response.should == {'error' => 'You need to sign in or sign up before continuing.'}
        end      
      end
    end

    describe "#create" do
      let(:post_create) do
        post :create, list: {name: "My new list"}, format: :json
      end

      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should add the record to the database" do
          expect {
            post_create
          }.to change(TaskList, :count).by(1)
        end

        it "should return 200 OK" do
          post_create
          response.should be_success
        end

        it "should return json of the just created record" do
          post_create
          json_response["id"].should == be_an(Integer)
          json_response["name"].should == "My new list"          
        end

        it "should raise ParameterMissing exception when task param is missing" do
          expect {
            post :create
          }.to raise_error(ActionController::ParameterMissing)
        end

        it "should ignore unknown parameters" do
          post :create, list: {name: "New List", foobar: 1234}
          response.should be_ok
        end
      end

      context "when not authenticated as that user" do
        it "should return HTTP 401 Unauthorized when trying to create a list" do
          post_create
          response.status.should == 401          
          json_response.should == {'error' => 'You need to sign in or sign up before continuing.'}
        end
      end
    end

    describe '#update' do
      let(:patch_update) do
        patch :update, id: first_list.id, list: {name: "Updated list"}, format: :json
      end
      
      context "when authenticated as that user" do
        before { sign_in(user) }      
        
        it "should update passed parameters of the given list" do
          patch_update
          first_list.reload.name.should == "Updated list"          
        end

        it "should return 200 OK" do
          patch_update
          response.should be_success
        end

        it "should raise RecordNotFound when trying to update non-existent task" do
          expect {
            patch :update, id: 0,
              list: {name: "Irrelevant name"}
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "should return HTTP 401 Unauthorized when trying to get a list of a another user" do
          patch :update, id: other_list.id, format: :json
          response.status.should == 401
          json_response.should == {'error' => 'unauthorized'}
        end
      end

      context "when not authenticated as that user" do
        it "should return error json with 401 HTTP status" do
          patch :update, id: first_list.id, format: :json
          response.status.should == 401
          json_response.should == {'error' => 'You need to sign in or sign up before continuing.'}
        end      
      end   
    end

    describe "#show" do
      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should return json with that task list" do
          get :show, id: first_list.id
          json_response.should == {"id" => first_list.id, "name" => first_list.name, "tasks" => first_list.tasks }
        end

        it "should raise RecordNotFound when trying to get a non-existent list" do
          expect {
            get :show, id: 0
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "should return HTTP 401 Unauthorized when trying to get a list of a another user" do
          get :show, id: other_list.id
          response.status.should == 401
          json_response.should == {'error' => 'unauthorized'}
        end
      end  

      context "when not authenticated as that user" do
        it "should return error json with 401 HTTP status" do
          get :show, id: first_list.id, format: :json
          response.status.should == 401
          json_response.should == {'error' => 'You need to sign in or sign up before continuing.'}
        end      
      end    
    end

    describe "#destroy" do
      let(:delete_destroy) do
        delete :destroy, id: second_list.id
      end

      context "when authenticated as that user" do
        before { sign_in(user) }
      
        it "should remove a list from the database" do        
          delete_destroy
          expect { second_list.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "should return 200 OK" do
          delete_destroy
          response.should be_success
        end

        it "should raise RecordNotFound when trying to destroy non-existent task" do
          expect {
            delete :destroy, id: 0
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it "should return HTTP 401 Unauthorized when trying to delete task of another user" do
          delete :destroy, id:  other_list.id
          response.status.should == 401
          json_response.should == {'error' => 'unauthorized'}
        end
      end

      context "when not authenticated as that user" do
        it "should return error json with 401 HTTP status" do
          delete :destroy, id: second_list.id, format: :json
          response.status.should == 401
          json_response.should == {'error' => 'You need to sign in or sign up before continuing.'}
        end      
      end 
    end
  end
end
