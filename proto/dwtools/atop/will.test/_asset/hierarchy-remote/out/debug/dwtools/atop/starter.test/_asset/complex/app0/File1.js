
console.log( 'app0/File1.js:begin' ); debugger;

var _ = require( 'wTools' );

console.log( 'numberIs' + ' ' + _.numberIs( 9 ) );

setTimeout( f, 1000 );

function f()
{
  console.log( 'app0/File1.js:timeout' + ' ' + _.numberIs( 0 ) );
}

module.exports = f;

console.log( 'app0/File1.js:end' );
