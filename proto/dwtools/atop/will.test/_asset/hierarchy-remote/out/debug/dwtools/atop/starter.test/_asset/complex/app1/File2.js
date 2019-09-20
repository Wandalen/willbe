
console.log( 'app1/File2.js:begin' ); debugger;

require( './File1.js' );

setTimeout( f, 1000 );

function f()
{
  console.log( 'app1/File2.js:timeout' );
}

module.exports = f;

console.log( 'app1/File2.js:end' );
