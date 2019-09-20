
console.log( 'app2/File2.js:begin main:' + !module.parent );

var f0 = require( '../app0/File1.js' );

setTimeout( f0, 1000 );

module.exports = f0;

console.log( 'app2/File2.js:end' );
