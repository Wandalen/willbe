
// debugger
// setTimeout( function()
// {

  console.log( 'app2/File2.js:begin main:' + !module.parent );

  var f0 = require( '../app0/File1.js' );

  // debugger;

  setTimeout( f0, 1000 );

  module.exports = f0;

  console.log( 'app2/File2.js:end' );

// }, 2000 );
