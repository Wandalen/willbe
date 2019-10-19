
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

  /* - */

  clone( 'Color', '01d8e996b03401c131a0deb2ad8201b23e89397b' );
  clone( 'PathBasic', '2e84d73699bdf5894fd3051169a1e2511a63e427' );
  clone( 'Procedure', '78d6af643b132a959675b7f0489ace2e9a6c4e60' );
  clone( 'Proto', 'b2054cc5549d24c421f4c71875e6da41fa36ffe0' );
  clone( 'Tools', '14163d4223466b178fec3adf67dc85a9ece32ad5' );
  clone( 'UriBasic', '382707a813d7b0a369aad2689f39c166930f9d87' );

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
