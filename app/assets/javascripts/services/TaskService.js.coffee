angular.module('todoApp').factory 'Task', ($resource) ->
  class Task
    constructor: (taskListId) ->
      @service = $resource('/api/task_lists/:task_list_id/tasks/:id',
        {task_list_id: taskListId, id: '@id'},
        {update: {method: 'PATCH'}})

    create: (attrs) ->
      new @service().$save(attrs)

    update: (task, attrs) ->
      new @service(id: task.id).$update(attrs)

    all: ->
      @service.query()
