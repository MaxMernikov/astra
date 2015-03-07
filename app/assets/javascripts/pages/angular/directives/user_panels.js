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
