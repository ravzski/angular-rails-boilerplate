Ctrl = ($scope,$state,User,growl,$http,Auth)->

  $scope.ctrl =
    loading: false
    creds: {}

  $scope.register =(user)->
    $scope.ctrl.loading = true
    User.save({user: user}).$promise
      .then (data) ->
        growl.success(MESSAGES.LOGIN_SUCCESS)
      .finally ->
        $scope.ctrl.loading = false


Ctrl.$inject = ['$scope','$state','User','growl','$http','Auth']
angular.module('client').controller('RegisterCtrl', Ctrl)
