angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $stateProvider
      .state 'admin.users',
        url: '/users',
        templateUrl: 'pages/users/index/index.html'
        controller: 'UsersIndexCtrl'


]
