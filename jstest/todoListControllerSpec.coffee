describe 'TodoListController', ->
  class Task
    constructor: (_) ->
    all: -> []
    create: (t) -> t
    delete: (_) ->

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

    describe 'addTask', ->
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

    describe 'and with one sample task', ->
      beforeEach ->
        @task = description: "Sample task", id: 1234
        @scope.tasks.push(@task)

      describe 'deleteTask', ->
        it 'should remove the task from the task list', ->
          @scope.deleteTask(@task)
          expect(@scope.tasks).toEqual([])

        it 'should call delete on taskService', ->
          spyOn(Task.prototype, 'delete')
          @scope.deleteTask(@task)
          expect(Task.prototype.delete).toHaveBeenCalledWith(@task)
