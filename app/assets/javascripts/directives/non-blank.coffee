# directive for inputs
# it sets required=true and handles white-space values
angular.module('todoApp').directive 'nonBlank', ->
  restrict: 'A'
  link: (scope, input, attrs) ->
    input[0].required = true
    
    # check input value before submit event is fired
    angular.element(input[0].form).find(':submit').bind 'click', (event) ->
      if isBlank(input.val())
        # this triggers 'required' error
        input.val("")
      
    isBlank = (text) ->
      !!text && text.length > 0 && !text.match(/\S/)

    