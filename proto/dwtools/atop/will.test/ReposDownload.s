
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

  clone( 'ModuleForTesting1', '64c96412c81266f119210e7af71e300cce5b2ebd' ); // Tools
  clone( 'ModuleForTesting1a', 'b6e7c97fe5549f720ce18d1058f5974feb981c4d' ); // Color
  clone( 'ModuleForTesting1b', '1c7838a05a7d88f56910c376b8170ec87a59c4b7' );
  clone( 'ModuleForTesting2', '8031560ec22fd955b0b57430b5d6d96b042fbd99' );
  clone( 'ModuleForTesting2a', '13d24b7b6527a1ad83715b12b7bb6f5df5313e90' ); // PathBasic
  clone( 'ModuleForTesting2b', 'e205f7bf2ad5c163723d4068e72b22db8411936f' ); // Procedure
  clone( 'ModuleForTesting12', '332f0fc961cd47a278a2b56f5b625cf5fa7fbae2' ); // Proto
  clone( 'ModuleForTesting12ab', 'b3499c8f6756cad511bb42559e6c3d501ed15061' ); // UriBasic

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
