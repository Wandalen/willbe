
setTimeout( f, 1000 );
for( let i = 0 ; i < 3 ; i++ )
console.log( 'File1.js:' + i );

function f()
{
  console.log( 'File1.js:timeout' );
}
