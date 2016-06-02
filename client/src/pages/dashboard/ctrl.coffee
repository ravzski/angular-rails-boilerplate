Ctrl = ($scope,$state,Project,$http,Streams,$timeout,Analytics,Auth,Settings,PushNotif,$rootScope,$window)->

  $rootScope.bodyClass = "locked"
  $scope.subContClass = {'height':"#{$window.innerHeight-100}", 'overflow-y': "auto"}

  $scope.refDate = Settings.getCurrentDayFromOffset($state.params.ref_date)
  $scope.offset = if !!$state.params.offset then parseInt($state.params.offset) else 0

  $scope.collapseData =
    failed_gpa: []
    failed_coverage: []
    failed_build: []
    failed_rejects: []
    failed_hours: []

  $scope.chartData =
    gpa: []
    coverage: []
    build: []
    hours: []
    rejects: []
  $scope.stats = null
  $scope.months = angular.copy MONTHS
  $scope.uiState =
    streamsLoading: true
    slideshow: false
    chartLoading: true
    currentDate: $scope.refDate
    fbLoading: false

  $scope.hoverPanel = ""
  $scope.currentDate = {}
  slideArr = ['first','second','third']
  $scope.slide = [false,false,false,false]
  $scope.slideGroup = [false,false,false,false]
  $scope.percent = 65
  $scope.timeouts = []

  $scope.pieOptions =
    util_opt: PIE_OPTIONS("#a979d1")
    client_sched: PIE_OPTIONS("#81B29A")
    util_rate: PIE_OPTIONS("#F2CC8F")

  $scope.currentChart =
    title: ""
    data: []
    redraw: false

  $scope.notifs = []
  firebase = PushNotif.getDb()
  fbNotifs = firebase.ref('feeds').orderByChild("created_at").limitToLast(100)

  $scope.getNotifs = ->
    fbNotifs.on 'child_added', (data) ->
      $scope.notifs.unshift data.val()
      $scope.$apply()

  $scope.toggleChart =(chart)->
    endpoint = Analytics.getEndpoint(chart)
    return if chart == $scope.currentChart.title
    if $scope.chartData[endpoint].length > 0
      $scope.currentChart =
        title: chart
        data: $scope.chartData[endpoint]
        redraw: true
    else
      $scope.uiState.chartLoading = true
      Analytics.charts({field: endpoint, ref_date: $scope.refDate.format(DATE_FORMAT)}).$promise
        .then (data) ->
          $scope.chartData[endpoint] = data
          $scope.currentChart =
            title: chart
            data: data
            redraw: true
          $scope.uiState.chartLoading = false

  $scope.getData = ->
    Analytics.dashboard({ref_date: $scope.refDate.format(DATE_FORMAT)}).$promise
      .then (data) ->
        $scope.stats = data.projects
        $scope.top_scores = data.top_scores
        $scope.slideshow_top_scores = data.top_scores
        $scope.currentChart.redraw = true
        $scope.uiState.chartLoading = false
        data.util_percent = data.streams.utilization_label.toPercent()
        $scope.streams = data.streams
        $scope.streams.top_workers = data.top_workers

    initial = Analytics.initialSeed()
    $scope.toggleChart(initial.chart,initial.endpoint)

  $scope.toggleDetails =(title)->
    endpoint = "failed_"+Analytics.getEndpoint(title)
    return if $scope.collapseData[endpoint].length > 0
    Analytics.details({field: endpoint,ref_date: $scope.refDate.format(DATE_FORMAT)}).$promise
      .then (data) ->
        $scope.collapseData[endpoint] = data

  $scope.showDetails =(current)->
    $scope.hoverPanel = current

  $scope.changeDate =(offset)->
    Settings.weekOffset(offset: offset).$promise
      .then (data) ->
        $state.go("admin.dashboard", {ref_date: data.date, offset: offset})

  $scope.getData()
  $scope.getNotifs()

  return

Ctrl.$inject = ['$scope','$state','Project','$http','Streams','$timeout','Analytics','Auth','Settings','PushNotif','$rootScope','$window']
angular.module('client').controller('DashboardCtrl', Ctrl)
