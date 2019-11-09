
function onModule( it )
{
  let o = it.request.map;
  let _ = it.tools;
  let logger = it.logger;
  let ready = it.ready;

  ready.then( () => it.fileProvider.filesDelete( it.path.join( it.junction.dirPath, 'node_modules' ) ) );
  ready.then( () => it.fileProvider.filesDelete( it.path.join( it.junction.dirPath, 'package-lock.json' ) ) );

  it.start( 'npm i' );

}

module.exports = onModule;
