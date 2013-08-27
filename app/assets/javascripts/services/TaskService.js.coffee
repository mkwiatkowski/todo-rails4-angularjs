angular.module('todoApp').factory 'Task', ($resource, $http) ->
  class Task
    constructor: (taskListId, errorHandler) ->
      @service = $resource('/api/task_lists/:task_list_id/tasks/:id',
        {task_list_id: taskListId, id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs) ->
      new @service(task: attrs).$save ((task) -> attrs.id = task.id), @errorHandler
      attrs

    delete: (task) ->
      new @service().$delete {id: task.id}, (-> null), @errorHandler

    update: (task, attrs) ->
      new @service(task: attrs).$update {id: task.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)
