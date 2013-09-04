angular.module('todoApp').controller "DashboardController", ($scope, $routeParams, $location, TaskList) ->
  listsService = new TaskList()

  $scope.init = ->        
    $scope.lists = listsService.all()

  $scope.createList = (name) ->
    listsService.create name: name, (list) ->
        $location.url("/task_lists/#{list.id}")

  $scope.deleteList = (list, index) ->
    listsService.delete list
    $scope.lists.splice index, 1
