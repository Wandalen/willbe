
let _ = require( '../../Tools.s' );
_.include( 'wAppBasic' );
_.include( 'wFiles' );

let = assetDirPath = _.path.join( __dirname, '_asset' );
let repoDirPath = _.path.join( assetDirPath, '_repo' );
let ready = new _.Consequence().take( null );
let start = _.process.starter
({
  currentPath : repoDirPath,
  outputCollecting : 1,
  ready : ready,
})

module.exports = reposRedownload;

//

function reposRedownload()
{

  ready.then( () =>
  {
    // _.fileProvider.filesDelete( repoDirPath );
    _.fileProvider.dirMake( repoDirPath );
    return null;
  });

  // clone( 'Color', '4ac65b56d4ca59d6e8ec48d3d70f410fae930ed3' ); */
  // clone( 'PathBasic', '622fb3c259013f3f6e2aeec73642645b3ce81dbc' );
  // clone( 'Procedure', 'd7b2cd8dc0a82a78343100462fe399c92cabe55c' );
  // clone( 'Proto', '70fcc0c31996758b86f85aea1ae58e0e8c2cb8a7' );
  // clone( 'Tools', '8fa27d72fe02d5e496b26e16669970a69d71fdb1' );
  // clone( 'UriBasic', 'd7022e6dcd5ab7f2d71aeb740d41a65dfaabdecf' );

  clone( 'ModuleForTesting1', '59f91c212a25036881719e8ad8111e7eff5cd8de' ); // Tools
  clone( 'ModuleForTesting1a', '5473eddb823eca9feaa160fd755b228e9a45f714' ); // Color
  clone( 'ModuleForTesting1b', '8fd07c9a8c168b3aec1c237ed31917d9b37ed69d' );
  clone( 'ModuleForTesting2', '57e945d5c246122a7838cd12ecbb03d820263a28' ); // PathBasic
  clone( 'ModuleForTesting2a', '9831fa07138b59d8584a1f3c3ad707e4760d4078' );
  clone( 'ModuleForTesting2b', '2baafef9994dddbd8a84ce9a65ee9fe7e0d95c5c' ); // UriBasic
  clone( 'ModuleForTesting12', '2162708236eee2f2d437ee65850eee55dc9a3fc2' ); // Proto
  clone( 'ModuleForTesting12ab', '3209a41397b16e62ac3e1123eae59da93f4b5b4b' ); // Procedure

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
