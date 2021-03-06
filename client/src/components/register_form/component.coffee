Ctrl = ->
  ctrl = this

  ctrl.$onInit = ->
    @.user =
      email: ""
      password: ""

  ctrl.submit =(form)->
    form.$submitted = true
    if form.$valid
      @.submit({user: @.user})

  return

angular.module('client').component 'registerForm',
  templateUrl: 'components/register_form/index.html'
  controller: Ctrl
  bindings:
    submit: "&"
