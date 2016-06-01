module = ($resource)->

  User = $resource "/api/users/:id", {id: "@id"},
    {
      resync:
        method: 'POST'
        url: "/api/users/resync"
      projects:
        method: 'GET'
        url: "/api/users/:id/projects"
        isArray: true
      rejects:
        method: 'GET'
        url: "/api/users/:id/rejects"
        isArray: true
      addProject:
        method: 'POST'
        url: "/api/users/:id/add_project"
      removeProject:
        method: "DELETE"
        url: "/api/users/:id/remove_project"
      update:
        method: 'PUT'
      stories:
        method: 'GET'
        url: "/api/users/:id/stories"
        isArray: false
      leaves:
        method: 'GET'
        url: "/api/users/:id/leaves"
        isArray: false
    }


module.$inject = ['$resource']
angular.module('client').factory('User', module)
