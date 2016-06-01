Ctrl = ->
  ctrl = this

  ctrl.$onInit = ->
    ctrl.creds.email = ''
    ctrl.creds.password = ''

  ctrl.submit =(form)=>
    form.$submitted = true
    if form.$valid
      this.login()

  return


angular.module('client').component 'loginForm',
  templateUrl: 'modules/login_form/index.html'
  controller: Ctrl
  bindings:
    login: "&"
    loading: "="
    creds: "="
