
console.log( 'app2/File1.js:begin main:' + !module.parent ); debugger;

setTimeout( f, 1000 );

function f()
{
  console.log( 'app2/File1.js:timeout' );
}

module.exports = f;

console.log( 'app2/File1.js:end' );
