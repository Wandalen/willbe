
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

  clone( 'ModuleForTesting1', '4688ca387496a5d973ecce385bb6abefd184847e' ); // Tools
  clone( 'ModuleForTesting1a', '4444f2a6edea7e545bb42fbe3b9f47b89ff0c32a' ); // Color
  clone( 'ModuleForTesting1b', '4adeb4fbace13c15a7fe82fee56240e4fe0abbc4' );
  clone( 'ModuleForTesting2', '080a7e2596e32ba0313bbe9260494df34f6fc49d' ); // PathBasic
  clone( 'ModuleForTesting2a', '87f8b8d301d4f5321442aa8012d63dc86bec7123' );
  clone( 'ModuleForTesting2b', '839fa7bb9bdb27e71cbfce203e4d80268456913f' ); // UriBasic
  clone( 'ModuleForTesting12', '5490549c4289cd870a41784b985990668b4a9ab3' ); // Proto
  clone( 'ModuleForTesting12ab', '9a837375d2ab7cc8c91d38b706f42c16e0b022fd' ); // Procedure

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
