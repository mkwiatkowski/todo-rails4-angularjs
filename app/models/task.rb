class Task < ActiveRecord::Base
  belongs_to :list, class_name: TaskList

  acts_as_list scope: :list, column: :priority, add_new_at: :top

  validates :description, presence: true, length: {maximum: 255}
  validates :list, presence: true

  def target_priority=(value)
    insert_at(value.to_i)
  end
end
