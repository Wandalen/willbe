
let willbePath = require.resolve( '..' );
let _ = require( 'wTools' )
_.include( 'wFiles' );
_.include( 'wProcess' );
_.include( 'wConsequence' );


if( process.platform === 'linux' )
{
  let getos = require('getos')

  let con = new _.Consequence();
  getos( con.tolerantCallback() );
  let dist = con.deasync().sync().dist;
  if( dist.toLowerCase() !== 'ubuntu' )
  return console.log( 'Cannot install package. Unsupported GNU/Linux distribution.' );
}

_.process.start
({
  execPath : 'node ' + willbePath,
  args : [ '.package.install package:///git#1:2.7.4-0ubuntu1.7' ],
  mode : 'spawn'
})
