Ctrl = ($scope,$state,Session,growl,$http,Auth)->

  $scope.ctrl =
    loading: false
    creds: {}

  $scope.login = ->
    $scope.ctrl.loading = true
    Session.login(credentials: $scope.ctrl.creds).$promise
      .then (data) ->
        $scope.ctrl.loading = false
        localStorage.setItem("access_token", data.access_token)
        localStorage.setItem("user_id", data.id)
        $http.defaults.headers.common.AccessToken = data.access_token
        $http.defaults.headers.common.UserId = data.id
        growl.success(MESSAGES.LOGIN_SUCCESS)
        $state.go("admin.dashboard")
      .finally ->
        $scope.ctrl.loading = false


Ctrl.$inject = ['$scope','$state','Session','growl','$http','Auth']
angular.module('client').controller('LoginCtrl', Ctrl)
