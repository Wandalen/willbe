
console.log( 'app2/File2.js:begin' ); debugger;

var f0 = require( '../app0/File1.js' );
var f1 = require( '../app1/File2.js' );

setTimeout( f1, 1000 );
setTimeout( f0, 1000 );

module.exports = f0;

console.log( 'app2/File2.js:end' );
