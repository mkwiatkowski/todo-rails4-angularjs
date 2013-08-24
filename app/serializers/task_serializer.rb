class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :priority, :due_date, :completed
end
