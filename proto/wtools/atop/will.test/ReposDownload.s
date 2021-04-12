
const _ = require( '../../../node_modules/Tools' );
_.include( 'wProcess' );
_.include( 'wFiles' );
_.include( 'wGitTools' );

let assetsOriginalPath = _.path.join( __dirname, '_asset' );
let repoDirPath = _.path.join( assetsOriginalPath, '-repo' );
let ready = _.take( null );
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

  clone( 'ModuleForTesting1', 'aed6304a687c22eb25a3af3c194000e7af4ac3f4' ); // Tools
  clone( 'ModuleForTesting1a', 'bdb0e6065a94e415095b6b085489ca8b41ba5bc9' ); // Color
  clone( 'ModuleForTesting1b', 'abf6b7f0f6c974829c6d1f35cd096cb34d22f58b' );
  clone( 'ModuleForTesting2', '0a9ac9ecbfbab54af8f99c61a9dd938659b065a1' );
  clone( 'ModuleForTesting2a', 'fb7c095a0fdbd6766b0d840ad914b5887c1500e7' ); // PathBasic
  clone( 'ModuleForTesting2b', '275a6d0d3f443525d1b542ad0d87a389c7adb339' ); // Procedure
  clone( 'ModuleForTesting12', '2da1d0de20bd23f6f32c11bda090569edd90da55' ); // Proto
  clone( 'ModuleForTesting12ab', 'a19813c715fa9ef8bb6a7c89adfa170e0e185971' ); // UriBasic

  /* qqq : for Dmytro : extend Remake. discuss */

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name ); /* qqq : for Dmytro : use routine _.git.* */
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) }); /* qqq : for Dmytro : use routine _.git.* */
  ready.then( () => _.git.reset({ localPath : _.path.join( repoDirPath, name ) }) )
  /* qqq : for Dmytro : implement and cover _.path.joiner */

}
