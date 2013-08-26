describe 'TodoListController', ->
  class Task
    constructor: (_) ->
    all: -> []
    create: (t) -> t

  beforeEach ->
    module('todoApp')

  beforeEach ->
    inject ($rootScope, $controller) =>
      @scope = $rootScope.$new()
      @ctrl  = $controller "TodoListController", $scope: @scope, Task: Task

  it 'should initialize scope.tasks to result of taskService.all()', ->
    spyOn(Task.prototype, 'all').andReturn([{description: 'Task 1'}])
    @scope.init()
    expect(@scope.tasks).toEqual([{description: 'Task 1'}])

  describe 'after initialization', ->
    beforeEach ->
      @scope.init()

    it 'should clear input when adding task', ->
      @scope.taskDescription = "First Task"
      @scope.addTask()
      expect(@scope.taskDescription).toEqual("")

    it 'should add new task to the begining of the tasks list', ->
      @scope.taskDescription = "Another Task"
      @scope.addTask()
      expect(@scope.tasks).toEqual([{description: "Another Task"}])

    it 'should pass new task to taskService.create', ->
      spyOn(Task.prototype, 'create')
      @scope.taskDescription = "One more thing"
      @scope.addTask()
      expect(Task.prototype.create).toHaveBeenCalledWith(description: "One more thing")
