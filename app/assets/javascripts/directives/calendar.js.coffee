angular.module('todoApp').directive 'calendar', ->
  restrict: 'E'
  transclude: true
  replace: true
  template: '<div ng-transclude class="calendar-button"></div>'
  scope:
    model: '='
    onChange: '&'
  link: (scope, element, attrs) ->
    createHiddenInput = ->
      input = angular.element("<input type='text'>")
      element.parent().append(input)
      hideInput(input)
      input

    hideInput = (input) ->
      input.css("width", "0")
      input.css("height", "0")
      input.css("opacity", "0")
      input.css("filter", "alpha(opacity=0)")
      input.css("-moz-opacity", "0")
      input.css("-khtml-opacity", "0")
      input.css("position", "relative")
      input.css("top", "-15px")

    hiddenInput = createHiddenInput()
    hiddenInput.datepicker({dateFormat: 'yy-mm-dd'})
    hiddenInput.datepicker('setDate', scope.model)

    element.bind "click", (event) ->
      hiddenInput.datepicker('show')

    hiddenInput.bind 'change', ->
      scope.model = hiddenInput.val()
      scope.$apply()
      scope.onChange()
      scope.$apply()
