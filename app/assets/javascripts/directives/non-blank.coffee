angular.module('todoApp').directive 'nonBlank', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    # check input value before submit event is fired
    element.find(':submit').bind 'click', (event) ->
      input = angular.element('#' + attrs['nonBlank'])
      if isBlank(input.val())
        # this triggers 'required' error
        input.val("")
      
    isBlank = (text) ->
      !!text && text.length > 0 && !text.match(/\S/)

