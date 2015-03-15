ChatApp.controller('ChatController',
  [

  '$scope',
  '$log',
  'ChatService',


  function ($scope, $log, ChatService) {

    $scope.initCtrl = function () {
      $scope.group = {};
      $scope.currentUser = {};
      $scope.message = '';
    };

    $scope.init = function (currentUser, group) {

      $scope.currentUser = currentUser;
      $scope.group = group;
    };

    // Actions
    $scope.sendMessage = function () {
      if($scope.message == '') return;

      ChatService.saveMessage($scope.message, $scope.currentUser.id, $scope.group.id).then(function (data) {


        }, function (error) {

          $log.error("Error in  API" + error);

        });

      };


    // On Ready
    $scope.initCtrl();
  
  }]);
