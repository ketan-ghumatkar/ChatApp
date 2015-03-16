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
      $scope.messages = [];
    };

    $scope.initRealTimeMessageHandler = function () {

      if (window.realtime.enabled) {
        // handle events in the queue without eventing
        var messageQueueConsoleLogger = function() {
          resp = window.realtime.messageQueue.shift();
          if (resp) {
            $(".chat").append('<li><p>'+ resp.msg.sender + ':' + resp.msg.content +'</p></li>')
          }
        };
        setInterval(messageQueueConsoleLogger, 100);
      } else {
        $log.error('Error: Realtime was not enabled.')
      }

    };

    $scope.init = function (currentUser, group) {

      $scope.currentUser = currentUser;
      $scope.group = group;

    };

    // Actions
    $scope.sendMessage = function () {
     
      if($scope.message == '') return;

      ChatService.saveMessage($scope.message, $scope.currentUser.id, $scope.group.id)
        .then(function (data) {

          $scope.message = '';

        }, function (error) {

          $log.error("Error in  API" + error);

        });

      };


    // On Ready
    $scope.initCtrl();
    $scope.initRealTimeMessageHandler();
  
  }]);
