require 'spec_helper'

describe Task do
  context "for three sample tasks in a list" do
    let(:list) { create(:task_list) }
    let!(:task3) { create(:task, list: list) }
    let!(:task2) { create(:task, list: list) }
    let!(:task1) { create(:task, list: list) }

    it "should reorder other tasks in the list when target_priority is set" do
      expect {
        task2.target_priority = 1
        task2.save!
      }.to change {[task1, task2, task3].map(&:reload).map(&:priority)}.from([1, 2, 3]).to([2, 1, 3])
    end
  end
end
