ChatApp.service('ChatService', ['$http', '$q', function($http, $q) {

  this.saveMessage = function (content, sender_id, recipient_id) {
    var deferred = $q.defer();
    var url = '/chats/save_message'
      , data = {
        content: content,
        sender_id: sender_id,
        recipient_id: recipient_id
      }

    $http({
          url: url,
          method: "POST",
          dataType: 'JSON', 
          data: data
        }).success(function (data) {
          deferred.resolve(data);
        }).error(function (error) {
          deferred.reject(error);
        });
    return deferred.promise;
  };
}]);
