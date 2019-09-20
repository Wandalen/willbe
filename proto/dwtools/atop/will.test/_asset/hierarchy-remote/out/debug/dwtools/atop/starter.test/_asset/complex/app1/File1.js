
console.log( 'app1/File1.js:begin' );

setTimeout( f, 1000 );

function f()
{
  console.log( 'app1/File1.js:timeout' );
}

module.exports = f;

console.log( 'app1/File1.js:end' );
