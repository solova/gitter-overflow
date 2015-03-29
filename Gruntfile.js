'use strict';
module.exports = function(grunt) {

  require('time-grunt')(grunt);
  require('load-grunt-tasks')(grunt);

  grunt.initConfig({
    mochacli: {
      options: {
        reporter: 'nyan',
        bail: true
      },
      all: ['tests.js']
    },
    coffee: {
      compile: {
        files: [{
          expand: true,
          cwd: 'src',
          src: ['{,*/}*.litcoffee'],
          dest: '.',
          rename: function(dest, src) {
            return dest + '/' + src.replace(/\.litcoffee$/, '.js');
          }
        },{
          expand: true,
          cwd: 'tests',
          src: ['{,*/}*.coffee'],
          dest: '.',
          rename: function(dest, src) {
            return dest + '/' + src.replace(/\.coffee$/, '.js');
          }
        }]
      }
    }
  });

  grunt.registerTask('test', ['mochacli']);
  grunt.registerTask('default', ['coffee:compile', 'mochacli']);
};
