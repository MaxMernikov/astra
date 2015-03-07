var app = angular.module('insta', [ ]);

app.config(function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content');
});

app.controller('UsersController', ['$http', '$scope', function($http, $scope){
  var users = this;
  users.collection = [];
  users.schedules = [];
  $scope.in_spudding = [];
  $scope.followers = [];

  $http.get('/admin/insta/insta_users').success(function(data){
    users.collection = data;
  })

  $http.get('/admin/insta/insta_users?type=in_spudding').success(function(data){
    $scope.in_spudding = data;
    console.log(data.with_date);
    t = data;
  })

} ]);

app.controller('SchedulesController', ['$http', '$scope', function($http, $scope){
  var schedules = this;

  $http.get('/admin/insta/insta_schedules/schedules').success(function(data){
    schedules.collection = data;
  });

  this.destroy = function(resource, index){
    $http({ method: 'DELETE', url: '/admin/insta/insta_schedules/' + resource.id }).success(function(data){
      schedules.collection.splice(index, 1);
    });
  };

  this.getInfo = function(resource){
    $http.get('/admin/insta/insta_users/' + resource.insta_user_id).success(function(data){
      $scope.$parent.followers = [data];
    })
  };

  this.setSchedule = function(){
    $http.get('/admin/insta/insta_schedules/set_schedule').success(function(data){
      schedules.collection = data;
    })
  };

}]);

app.controller('PanelController', function(){
  this.tab = 1;

  this.selectTab = function(setTab){
    this.tab = setTab;
  };

  this.isSelected = function(checkTab){
    return this.tab === checkTab;
  };
});

