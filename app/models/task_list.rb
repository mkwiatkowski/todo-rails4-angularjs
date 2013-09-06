class TaskList < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :tasks, -> { order :priority }, foreign_key: :list_id, dependent: :destroy

  validates :owner, presence: true
  validates :name, presence: true
end
