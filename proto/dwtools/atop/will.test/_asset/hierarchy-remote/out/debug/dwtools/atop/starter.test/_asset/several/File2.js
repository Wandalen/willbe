
require( './File1.js' );

setTimeout( f, 1000 );
for( let i = 0 ; i < 3 ; i++ )
console.log( 'File2.js:' + i );

function f()
{
  console.log( 'File2.js:timeout' );
}
