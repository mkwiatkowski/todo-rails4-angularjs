describe 'TodoListController', ->
  class Task
    constructor: (_) ->
    all: -> []
    create: (t) -> t
    delete: (_) ->

  beforeEach ->
    module('todoApp')

  beforeEach ->
    inject ($rootScope, $controller, $injector, TaskList) =>
      @TaskList = TaskList     
      spyOn(@TaskList.prototype, 'find').andReturn({name: "Your list", tasks: [{description: 'Task 1'}]})
      @scope = $rootScope.$new()
      @ctrl  = $controller "TodoListController", $scope: @scope, TaskList: @TaskList, Task: Task

  it 'should initialize scope.tasks to result of taskListService.find', ->
    @scope.init()
    expect(@scope.list.tasks).toEqual([{description: 'Task 1'}])

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
        firstTask = @scope.list.tasks[0]
        expect(firstTask.description).toEqual("Another Task")
        expect(firstTask.priority).toEqual(1)

      it 'should pass new task to taskService.create', ->
        spyOn(Task.prototype, 'create').andReturn({})
        @scope.taskDescription = "One more thing"
        @scope.addTask()
        expect(Task.prototype.create).toHaveBeenCalledWith(description: "One more thing")

    describe 'and with one sample task', ->
      beforeEach ->
        @task = description: "Sample task", id: 1234
        @scope.list.tasks = [@task]

      describe 'deleteTask', ->
        it 'should remove the task from the task list', ->
          @scope.deleteTask(@task)
          expect(@scope.list.tasks).toEqual([])

        it 'should call delete on taskService', ->
          spyOn(Task.prototype, 'delete')
          @scope.deleteTask(@task)
          expect(Task.prototype.delete).toHaveBeenCalledWith(@task)
