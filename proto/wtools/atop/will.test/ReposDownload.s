
let _ = require( '../../../wtools/Tools.s' );
_.include( 'wProcess' );
_.include( 'wFiles' );

let assetsOriginalPath = _.path.join( __dirname, '_asset' );
let repoDirPath = _.path.join( assetsOriginalPath, '-repo' );
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

  /* the latest gamma versions */

  // clone( 'ModuleForTesting1', '32608d8cf3f87365218427c645c3b55949a7208d' ); // Tools
  // clone( 'ModuleForTesting1a', '47dc1d2608de27aaac4299a7932abcde9de0ae85' ); // Color
  // clone( 'ModuleForTesting1b', '212a134a6882622f9d965c979429bd6756dda95d' );
  // clone( 'ModuleForTesting2', 'c24deb6104d2275eb9e3f7e8927de6c841ad444a' );
  // clone( 'ModuleForTesting2a', '49cc502b0e83f091efe6cafec83ba6d4716bcc50' ); // PathBasic
  // clone( 'ModuleForTesting2b', '2829d7a9212792209aaed6ade83fbd2729f4cffb' ); // Procedure
  // clone( 'ModuleForTesting12', '6f81448163920ac9b982d6071c54a3fd1f3ea150' ); // Proto
  // clone( 'ModuleForTesting12ab', '1b9ff0d20b7dd17398aa4283945c70279c2962ab' ); // UriBasic

  /* the latest delta versions */

  clone( 'ModuleForTesting1', '3de7741c7ba475b912411b35ee3cf2ab44a0a901' ); // Tools
  clone( 'ModuleForTesting1a', '8eeb3e89518c6a9d060fdf7bdee37baaaa9a451b' ); // Color
  clone( 'ModuleForTesting1b', '026233546add0b70b734e68a317f57e32abf437b' );
  clone( 'ModuleForTesting2', '42441628a94c3ebf98093e158fe02ec2cba53761' );
  clone( 'ModuleForTesting2a', 'fc6285084b7b0110d6dd56ac808fef673c4fb6d4' ); // PathBasic
  clone( 'ModuleForTesting2b', '352570f723ba34ca3b7996cd83a5242be29d687c' ); // Procedure
  clone( 'ModuleForTesting12', 'bc3ec4133f3fc6bc296c0488f52f06eb6f26a1e8' ); // Proto
  clone( 'ModuleForTesting12ab', 'f0d93ce60671b622a2daa57ea32017afc5af08e1' ); // UriBasic

  /* qqq : for Dmytro : extend Remake. discuss */

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
