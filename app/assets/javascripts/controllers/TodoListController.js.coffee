angular.module('todoApp').controller "TodoListController", ($scope, Task) ->
  $scope.sortMethod = 'priority'
  $scope.sortableEnabled = true

  $scope.init = (taskListId) ->
    @taskService = new Task(taskListId)
    $scope.tasks = @taskService.all()

  $scope.addTask = ->
    task = @taskService.create(description: $scope.taskDescription)
    $scope.tasks.unshift(task)
    $scope.taskDescription = ""

  $scope.deleteTask = (task) ->
    @taskService.delete(task)
    $scope.tasks.splice($scope.tasks.indexOf(task), 1)

  $scope.toggleTask = (task) ->
    @taskService.update(task, completed: task.completed)

  $scope.taskEdited = (task) ->
    @taskService.update(task, description: task.description)

  $scope.dueDatePicked = (task) ->
    @taskService.update(task, due_date: task.due_date)

  $scope.priorityChanged = (task) ->
    @taskService.update(task, target_priority: task.priority)

  $scope.sortableOptions =
    update: (e, ui) ->
      domIndexOf = (e) -> e.siblings().andSelf().index(e)
      newPriority = domIndexOf(ui.item) + 1

      task = ui.item.scope().task
      task.priority = newPriority

      $scope.priorityChanged(task)

  $scope.changeSortMethod = (sortMethod) ->
    $scope.sortMethod = sortMethod
    if sortMethod == 'priority'
      enableSortable()
    else
      disableSortable()

  $scope.dueDateNullLast = (task) ->
    task.due_date ? '2999-12-31'

  enableSortable = ->
    $scope.sortableEnabled = true

  disableSortable = ->
    $scope.sortableEnabled = false
