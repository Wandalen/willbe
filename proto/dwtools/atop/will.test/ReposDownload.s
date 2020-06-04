
let _ = require( '../../../dwtools/Tools.s' );
_.include( 'wAppBasic' );
_.include( 'wFiles' );

let = assetsOriginalPath = _.path.join( __dirname, '_asset' );
let repoDirPath = _.path.join( assetsOriginalPath, '_repo' );
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

  // clone( 'ModuleForTesting1', 'ea9c4c13030724406dc9896171a9d4e12d3bfedf' ); // Tools
  // clone( 'ModuleForTesting1a', '3ab5bd8bf672538571f2378e11be7f47e6e58414' ); // Color
  // clone( 'ModuleForTesting1b', 'a6a8a6e4fa650c034e8a0ae2cc85a74f3031a01a' );
  // clone( 'ModuleForTesting2', '6d2a274c756af06121fefdd41f756bf2635943d3' ); // PathBasic
  // clone( 'ModuleForTesting2a', '5bd7ebfbe9e95f37de3468013087d87eb0bc1f3d' );
  // clone( 'ModuleForTesting2b', '60e5b51fbb0853fd2f3b90b15fe6c93ae1d82745' ); // UriBasic
  // clone( 'ModuleForTesting12', 'be2c704e5cb4ee2b80a067b6ee9bf3217e72b770' ); // Proto
  // clone( 'ModuleForTesting12ab', 'e5e33c19dbbdbcbc7605a4fd542d39de3b011645' ); // Procedure

  clone( 'ModuleForTesting1', '6d6d4b457a15a4cc020b217fe07b8619a9018606' ); // Tools
  clone( 'ModuleForTesting1a', 'cf9c9939c5c37519c50cc97f68530f7fe261c32c' ); // Color
  clone( 'ModuleForTesting1b', 'd7c3d0fc155b0f836c2eca613a0c52424c295a19' );
  clone( 'ModuleForTesting2', '610df5aa934c9303be579b5ee6ec3cea2f4fdf0e' );
  clone( 'ModuleForTesting2a', '98f19db1a770050eb4e8ec0fc39130acc8b29864' ); // PathBasic
  clone( 'ModuleForTesting2b', 'e324cd8dac97e946e19830fff49604c1be34736a' ); // Procedure
  clone( 'ModuleForTesting12', 'bf302ab00697a7ccfd41adf157c1858204077ca2' ); // Proto
  clone( 'ModuleForTesting12ab', '504cd5981bb14ec083f213ee6d40bdb4df448a5a' ); // UriBasic

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
