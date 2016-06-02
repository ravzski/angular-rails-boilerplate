angular.module('client').run [
  '$rootScope','$location','$state','$window','$http','Session','Auth', ($rootScope,$location,$state,$window,$http,Session,Auth) ->

    $rootScope.authenticatorFlag = true

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      return if (toState.name == "login" || toState.name == 'register') && !localStorage.getItem('access_token')

      if $rootScope.authenticatorFlag
        event.preventDefault()
        $rootScope.authenticatorFlag = false
        $http.defaults.headers.common.AccessToken = localStorage.getItem('access_token')
        $http.defaults.headers.common.UserId = localStorage.getItem('user_id')

        if((toState.name == "login" || toState.name == 'register') && !!localStorage.getItem('access_token'))
          $state.go("admin.dashboard")
        else if(user = Auth.getUser())
          $state.go(toState.name, toParams)
        else
          Session.getCurrentUser().$promise
            .then (data) ->
              Auth.setUser(data)
              $state.go(toState.name, toParams)

]
