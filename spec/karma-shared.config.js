var shared = {
  // base path, that will be used to resolve files and exclude
  basePath: '..',

  // frameworks to use
  frameworks: [],

  plugins: [
    'karma-coffee-preprocessor',
    'karma-chrome-launcher'
  ],

  // list of files / patterns to load in the browser
  files: [
    'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js',
    'http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js',
    'https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0/angular.min.js',
    'https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0/angular-route.min.js',
    'public/js/moment.min.js',
    'public/js/ui-bootstrap-0.6.0.min.js',
    'public/js/ui-bootstrap-tpls-0.6.0.min.js',
    'public/js/app.js',
    'public/js/services/*.js',
    'public/js/models/*.js',
    'public/js/controllers/*.js',
    'public/js/routes.js',
    'spec/http_backend_mocker.coffee'
  ],

  // list of files to exclude
  exclude: [],

  preprocessors: {
    '**/*.coffee': ['coffee']
  },

  // test results reporter to use
  // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
  reporters: ['progress'],

  // web server port
  port: 9876,

  // enable / disable colors in the output (reporters and logs)
  colors: true,

  // enable / disable watching file and executing tests whenever any file changes
  autoWatch: true,

  // Start these browsers, currently available:
  // - Chrome
  // - ChromeCanary
  // - Firefox
  // - Opera
  // - Safari (only Mac)
  // - PhantomJS
  // - IE (only Windows)
  browsers: ['Chrome'],

  // If browser does not capture in given timeout [ms], kill it
  captureTimeout: 60000,

  // Continuous Integration mode
  // if true, it capture browsers, run tests and exit
  singleRun: false
};

exports.shared = shared;
