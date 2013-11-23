module.exports = function(karma) {
  config = require(__dirname + '/karma-shared.config.js').shared;

  config.frameworks = config.frameworks.concat([
    'ng-scenario'
  ]);

  config.plugins = config.plugins.concat([
    'karma-ng-scenario'
  ]);

  // level of logging
  // possible values: karma.LOG_DISABLE || karma.LOG_ERROR || karma.LOG_WARN || karma.LOG_INFO || karma.LOG_DEBUG
  // config.logLevel = config.LOG_INFO;

  config.files = config.files.concat([
    'http://code.angularjs.org/1.2.0/angular-resource.min.js',
    'spec/e2e/**/*_spec.coffee',
    'spec/e2e/test_playlister_app.coffee',
    {
      pattern: 'public/css/*',
      watched: true,
      included: false,
      served: true
    },
    {
      pattern: 'public/css/fonts/*',
      watched: false,
      included: false,
      served: true
    },
    {
      pattern: 'spec/test-index.html',
      watched: true,
      included: false,
      served: true
    },
    {
      pattern: 'public/*.html',
      watched: true,
      included: false,
      served: true
    }
  ]);

  config.proxies = {
    '/rdio_login.html': 'http://localhost:' + config.port +
                        '/base/public/rdio_login.html',
    '/lastfm_tracks.html': 'http://localhost:' + config.port +
                           '/base/public/lastfm_tracks.html',
    '/lastfm_user.html': 'http://localhost:' + config.port +
                         '/base/public/lastfm_user.html',
    '/lastfm_weeks.html': 'http://localhost:' + config.port +
                          '/base/public/lastfm_weeks.html'
  };

  karma.set(config)
};
