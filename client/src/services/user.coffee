module = ($resource)->

  User = $resource "/api/users/:id", {id: "@id"},
    {
      update:
        method: 'PUT'
    }


module.$inject = ['$resource']
angular.module('client').factory('User', module)
