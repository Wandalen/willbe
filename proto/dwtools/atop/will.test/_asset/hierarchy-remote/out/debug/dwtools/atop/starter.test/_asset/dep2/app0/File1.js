
console.log( 'app0/File1.js:begin main:' + !module.parent );

debugger;
// var _ = require( 'wTools' );
// console.log( 'numberIs:' + _.numberIs( 9 ) );

setTimeout( f, 1000 );

function f()
{
  console.log( 'app0/File1.js:timeout' );
}

module.exports = f;

console.log( 'app0/File1.js:end' );
