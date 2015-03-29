#!/usr/bin/env node
'use strict';
var meow = require('meow');
var gitterOverflow = require('./GitterOverflow');
var config = require('./config.json');

var cli = meow({
  help: [
    'Usage',
    '  node bot.js <room>',
    '',
    'Example',
    '  node bot.js solova/gitter-overflow'
  ].join('\n')
});

if (cli.input.length === 0){
  console.log(cli.help);
}else{
  gitterOverflow(cli.input[0], config.token);
}
