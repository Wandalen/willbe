
console.log( 'app0/File2.js:begin' ); debugger;

let f = require( '../app2/File2.js' );

setTimeout( f, 1000 );

module.exports = f;

console.log( 'app0/File2.js:end' );
