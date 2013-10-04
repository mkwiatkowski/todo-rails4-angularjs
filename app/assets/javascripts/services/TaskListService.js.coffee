angular.module('todoApp').factory 'TaskList', ($resource, $http) ->
  class TaskList
    constructor: (errorHandler) ->
      @service = $resource('/api/task_lists/:id',
        {id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for the PATCH method to use application/json content type.
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @service(list: attrs).$save ((list) -> successHandler(list)), @errorHandler      

    delete: (list) ->
      new @service().$delete {id: list.id}, (-> null), @errorHandler

    update: (list, attrs) ->
      new @service(list: attrs).$update {id: list.id}, (-> null), @errorHandler
      
    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id, ((list)-> 
        successHandler?(list)
        list), 
       @errorHandler)

