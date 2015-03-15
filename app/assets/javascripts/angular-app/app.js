ChatApp = angular.module('chatApp', []);

ChatApp.config([
  '$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

ChatApp.run(function () {
  console.log('Chat app running');
});