
let _ = require( '../../../wtools/Tools.s' );
_.include( 'wProcess' );
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

  clone( 'ModuleForTesting1', 'e96f5405a2f23912957c4b7baa0a0ddf4ac6ca24' ); // Tools
  clone( 'ModuleForTesting1a', '4260cd83841c94baef1d8aa85c48d50e03f1fb46' ); // Color
  clone( 'ModuleForTesting1b', '92ba8ff3bef1a26907e3a85ad62d619aa6047d36' );
  clone( 'ModuleForTesting2', 'a37826f11bd1801b1e5d727bdf38a738fb2f783c' );
  clone( 'ModuleForTesting2a', '48023b1e3d064b473e491be4bd5f7f789ce5c288' ); // PathBasic
  clone( 'ModuleForTesting2b', '6a1372610cc61b3c7a70ae666e15f20641668c9b' ); // Procedure
  clone( 'ModuleForTesting12', '5e2aa08b36f97889dc29291292816a0191f7939f' ); // Proto
  clone( 'ModuleForTesting12ab', 'cef20499c8dae0bf6d8b288be63b2c031ad34551' ); // UriBasic

  return ready;
}

//

function clone( name, version )
{

  if( !_.fileProvider.isDir( _.path.join( repoDirPath, name ) ) )
  start( 'git clone https://github.com/Wandalen/w' + name + '.git ' + name );
  start({ execPath : 'git checkout ' + version, currentPath : _.path.join( repoDirPath, name ) });

}
