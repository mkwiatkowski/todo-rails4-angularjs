require 'spec_helper'

describe TaskList do
  it "should raise validation error when owner wasn't provided" do
    expect {
      create(:task_list, owner: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  context "for new valid task list" do
    let(:task_list) { create(:task_list) }

    it "should have an empty list of tasks" do
      task_list.tasks.should == []
    end

    it "should order tasks by priority" do
      # New tasks go to the top, LIFO.
      t3 = create(:task, list: task_list)
      t2 = create(:task, list: task_list)
      t1 = create(:task, list: task_list)
      task_list.tasks.should == [t1.reload, t2.reload, t3.reload]
    end
  end
end
