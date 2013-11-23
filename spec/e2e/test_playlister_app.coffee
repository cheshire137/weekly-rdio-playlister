angular.module('TestPlaylisterApp', ['PlaylisterApp', 'ngMockE2E']).run ($httpBackend) ->
  http_backend_mocker.mock_shared_routes $httpBackend
  http_backend_mocker.mock_e2e_routes $httpBackend
