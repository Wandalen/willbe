
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

  /* Dmytro : the latest delta versions */

  clone( 'ModuleForTesting1', '58881174e8edbd7c54761296694e0b48a4997e65' ); // Tools
  clone( 'ModuleForTesting1a', '44e40eef6a64196afcf1f9b51fcb8f8be71ded1d' ); // Color
  clone( 'ModuleForTesting1b', '0c04fe663066afc03767e23c71d921978595fddf' );
  clone( 'ModuleForTesting2', 'cd27a51294bc00bcbc2212f9d9ac5b4a82529990' );
  clone( 'ModuleForTesting2a', '85db26267c91f794efeb85ae5ade77a33cc3c645' ); // PathBasic
  clone( 'ModuleForTesting2b', '9eb65ca0d7f41ba9d9562c6d8a1c5f27653f9ff0' ); // Procedure
  clone( 'ModuleForTesting12', '1e0b8cc041bb0f3aa105b2577947c2884694b4df' ); // Proto
  clone( 'ModuleForTesting12ab', 'a15e971510b340106f1b9872bf7b939452c267eb' ); // UriBasic

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
