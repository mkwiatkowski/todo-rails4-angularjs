require 'spec_helper'

describe User do
  context "for new valid user" do
    let(:user) { create(:user) }

    it "should have a corresponding task list" do
      user.task_list.should be_a(TaskList)
    end
  end
end
