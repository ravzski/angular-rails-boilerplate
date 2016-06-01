angular.module('client').config [
  '$stateProvider','$locationProvider','$urlRouterProvider'
  ($stateProvider,$locationProvider,$urlRouterProvider) ->

    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/login')

    $stateProvider
      .state 'login',
        url: '/login',
        templateUrl: 'pages/login/index.html'
        controller: 'LoginCtrl'

      .state 'admin',
        url: '/admin',
        templateUrl: 'pages/admin/index.html'
        controller: 'AdminCtrl'
        abstract: true

      .state 'admin.dashboard',
        url: '/dashboard?ref_date&offset',
        templateUrl: 'pages/dashboard/index.html'
        controller: 'DashboardCtrl'

]
