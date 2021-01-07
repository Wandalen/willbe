
let _ = require( '../../../wtools/Tools.s' );
_.include( 'wProcess' );
_.include( 'wFiles' );

let assetsOriginalPath = _.path.join( __dirname, '_asset' );
let repoDirPath = _.path.join( assetsOriginalPath, '_repo' );
let ready = new _.Consequence().take( null );
let start = _.process.starter
({
  currentPath : repoDirPath,
  outputCollecting : 1,
  ready,
});

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

  /* Dmytro : the latest gamma versions */

  // clone( 'ModuleForTesting1', '32608d8cf3f87365218427c645c3b55949a7208d' ); // Tools
  // clone( 'ModuleForTesting1a', '47dc1d2608de27aaac4299a7932abcde9de0ae85' ); // Color
  // clone( 'ModuleForTesting1b', '212a134a6882622f9d965c979429bd6756dda95d' );
  // clone( 'ModuleForTesting2', 'c24deb6104d2275eb9e3f7e8927de6c841ad444a' );
  // clone( 'ModuleForTesting2a', '49cc502b0e83f091efe6cafec83ba6d4716bcc50' ); // PathBasic
  // clone( 'ModuleForTesting2b', '2829d7a9212792209aaed6ade83fbd2729f4cffb' ); // Procedure
  // clone( 'ModuleForTesting12', '6f81448163920ac9b982d6071c54a3fd1f3ea150' ); // Proto
  // clone( 'ModuleForTesting12ab', '1b9ff0d20b7dd17398aa4283945c70279c2962ab' ); // UriBasic

  /* Dmytro : the latest alpha versions */

  clone( 'ModuleForTesting1', '4418bd34a5fc1a89c6bd992cc17651875ee89583' ); // Tools
  clone( 'ModuleForTesting1a', 'e271b20eed4228405f360f5fed1813f39e7ce359' ); // Color
  clone( 'ModuleForTesting1b', '5748533cb8a60b14c54254c51e99612cdbbf25cf' );
  clone( 'ModuleForTesting2', '3fb273a84b322ee36691670ee4724bae53a87e9f' );
  clone( 'ModuleForTesting2a', '4b5db5437558300dc791acfd2b5304923063fcc6' ); // PathBasic
  clone( 'ModuleForTesting2b', 'ee23617c6135eaac3a2fbc0caa8eb6e82e8c8afd' ); // Procedure
  clone( 'ModuleForTesting12', 'a46a195fbefa0e7454e5a75c7263023e5e483d6b' ); // Proto
  clone( 'ModuleForTesting12ab', '5825b2537e6dcc1c2ca14fe4cedb8d9917bf17c8' ); // UriBasic

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
