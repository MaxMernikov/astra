$(function() {
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

  app.directive('userPanels', function(){
    return {
      require: 'UsersController',
      restruct: 'E',
      templateUrl: '/admin/insta/partial?type=user_panels',
      controller: ['$http', '$scope', function($http, $scope){
        this.body_active = false;

        this.relationshipUpdate = function(resource){
          $http.get('/admin/insta/insta_users/' + resource.user.id + '/relationship.json').success(function(data){
            resource.user = data;
          })
        };

        this.infoUpdate = function(resource){
          $http.get('/admin/insta/insta_users/' + resource.user.id + '/info.json').success(function(data){
            resource.user = data;
          })
          this.body_active = true;
        };

        this.get_followed_by = function(resource){
          $http.get('/admin/insta/insta_users/' + resource.user.id + '/followers.json').success(function(data){
            $scope.$parent.$parent.followers = data;
          })
        }

        this.spud = function(resource, index){
          $http.get('/admin/insta/insta_users/' + resource.user.id + '/spud').success(function(data){
            $scope.$parent.followers.splice(index, 1);
            $scope.$parent.in_spudding.without_date.unshift(data);
          })
        };

        this.reset_spud = function(resource, index){
          $http.get('/admin/insta/insta_users/' + resource.user.id + '/reset_spud').success(function(data){
            $scope.$parent.in_spudding.without_date.splice(index, 1);
          })
        }

        this.body_toddle = function(){
          this.body_active = !this.body_active;
        };

      }],
      controllerAs: 'users'
    };
  });

});