require 'spec_helper'

describe User do
  context "for new valid user" do
    let(:user) { create(:user) }

    it "should have a corresponding first task list" do
      user.task_lists.first.should be_a(TaskList)
    end
  end
end
