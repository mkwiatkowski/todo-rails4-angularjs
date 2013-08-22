class TaskList < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :tasks, foreign_key: :list_id

  validates :owner, presence: true
end
