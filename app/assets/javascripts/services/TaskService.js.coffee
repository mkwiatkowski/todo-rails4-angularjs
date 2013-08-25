angular.module('todoApp').factory 'Task', ($resource) ->
  class Task
    constructor: (taskListId) ->
      @service = $resource('/api/task_lists/:task_list_id/tasks', {task_list_id: taskListId})

    create: (attrs) ->
      task = new @service(attrs)
      task.$save()

    all: ->
      @service.query()
