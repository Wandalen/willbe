
'use strict';

const { JSDOM } = require( 'jsdom' );

const options =
{
  resources: 'usable',
  runScripts: 'dangerously',
};

JSDOM.fromFile( 'Browser.html', options );

