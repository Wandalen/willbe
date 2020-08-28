
let willbePath = require.resolve( '..' );
let _ = require( 'wTools' );
let getos = require( 'getos' );
_.include( 'wFiles' );
_.include( 'wProcess' );
_.include( 'wConsequence' );

/* */

if( !( process.platform === 'linux' ) )
return console.log( 'Unsupported operating system' );

let con = new _.Consequence();
getos( con.tolerantCallback() );
let dist = con.deasync().sync().dist;
if( dist.toLowerCase() !== 'ubuntu' )
return console.log( 'Cannot install package. Unsupported GNU/Linux distribution.' );

/* */

_.process.start
({
  execPath : 'node ' + willbePath,
  args : [ '.package.install package:///htop sudo:1' ],
  // args : [ '.package.install package:///git#1:2.7.4-0ubuntu1.7' ],
  mode : 'spawn',
})
